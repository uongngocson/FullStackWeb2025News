package local.example.demo.controller.admin;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import local.example.demo.model.entity.ProductVariant;
import local.example.demo.service.ProductVariantService;
import local.example.demo.service.S3FileService;

@Controller
@RequestMapping("admin/dashboard/")
public class Generate3DimageController {

    @Autowired
    private ProductVariantService productVariantService;
    
    @Autowired
    private S3FileService s3FileService;
    // generate 3d image AUTO
    @GetMapping("generateauto")
    public String getGenerateAutoPage(Model model) {
        // Get all product variants
        List<ProductVariant> allVariants = productVariantService.findAll();
        
        // Filter variants that have imageUrl but no image_url3d (null or empty)
        List<ProductVariant> variantsNeed3DImage = allVariants.stream()
            .filter(variant -> variant.getImageUrl() != null && !variant.getImageUrl().isEmpty())
            .filter(variant -> variant.getImage_url3d() == null || variant.getImage_url3d().isEmpty())
            .collect(Collectors.toList());
        
        System.out.println("Found " + variantsNeed3DImage.size() + " variants needing 3D images");
        
        // Add the filtered variants to the model
        model.addAttribute("variantsNeed3DImage", variantsNeed3DImage);
        
        return "admin/image-gener/generateauto";
    }

    // admin navigation to 3D image management page
    @GetMapping("createimage3d")
    public String getDashboardPage(Model model, 
                                  @RequestParam(required = false) Integer productId) {
        List<ProductVariant> productVariants;
        
        // If productId is provided, filter variants by that product
        if (productId != null) {
            productVariants = productVariantService.findVariantsByProductId(productId);
            model.addAttribute("selectedProductId", productId);
        } else {
            // Otherwise, get all variants
            productVariants = productVariantService.findAll();
        }
        
        model.addAttribute("productVariants", productVariants);
        return "admin/image-gener/createimage3d";
    }
    
    // Method to handle 3D image upload
    @PostMapping("upload3dimage")
    @ResponseBody
    public String upload3DImage(@RequestParam("file") MultipartFile file,
                              @RequestParam("variantId") Integer variantId) {
        try {
            System.out.println("=== Starting 3D file upload process ===");
            System.out.println("VariantId: " + variantId);
            
            if (file == null) {
                System.out.println("Error: File is null");
                return "File is null";
            }
            
            System.out.println("File details - Name: " + file.getOriginalFilename() + 
                             ", Size: " + file.getSize() + " bytes, Content Type: " + file.getContentType());
            
            ProductVariant variant = productVariantService.findById(variantId);
            if (variant == null) {
                System.out.println("Error: Variant not found for ID " + variantId);
                return "Variant not found";
            }
            
            // Check if file is empty
            if (file.isEmpty()) {
                System.out.println("Error: Empty file provided");
                return "Please select a file to upload";
            }
            
            // Check if file is a valid 3D model type
            String originalFilename = file.getOriginalFilename();
            if (originalFilename == null || 
                !(originalFilename.endsWith(".glb") || 
                  originalFilename.endsWith(".gltf") || 
                  originalFilename.endsWith(".obj") || 
                  originalFilename.endsWith(".fbx"))) {
                System.out.println("Error: Invalid file format: " + originalFilename);
                return "Only GLB, GLTF, OBJ, and FBX files are allowed";
            }
            
            // Log file information
            System.out.println("Uploading file: " + originalFilename + ", Size: " + file.getSize() + " bytes");
            
            // Apply special handling for GLB files
            boolean isGlbFile = originalFilename.toLowerCase().endsWith(".glb");
            if (isGlbFile) {
                System.out.println("GLB file detected - will apply GZIP compression for HTTP transfer");
            }
            
            // If there's an existing 3D image URL, delete it from S3
            if (variant.getImage_url3d() != null && !variant.getImage_url3d().isEmpty()) {
                try {
                    System.out.println("Deleting previous file: " + variant.getImage_url3d());
                    s3FileService.deleteFile(variant.getImage_url3d());
                } catch (Exception e) {
                    // Log the error but continue with the upload
                    System.err.println("Error deleting previous file: " + e.getMessage());
                }
            }
            
            // Upload to S3 and get the URL
            System.out.println("Starting S3 upload...");
            String s3FileUrl = s3FileService.uploadFile(file, "3Dmodel/");
            System.out.println("File successfully uploaded to S3: " + s3FileUrl);
            
            // Save the URL to the database
            variant.setImage_url3d(s3FileUrl);
            productVariantService.save(variant);
            System.out.println("Database updated with new image URL");
            
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error during file upload: " + e.getMessage());
            // Print detailed stack trace for debugging
            for (StackTraceElement element : e.getStackTrace()) {
                System.err.println("  at " + element.toString());
            }
            return "Error: " + e.getMessage();
        }
    }
    
    // Method to handle 3D image deletion
    @PostMapping("delete3dimage")
    @ResponseBody
    public String delete3DImage(@RequestParam("variantId") Integer variantId) {
        try {
            ProductVariant variant = productVariantService.findById(variantId);
            if (variant == null) {
                return "Variant not found";
            }
            
            // If there's an existing 3D image URL, delete it from S3
            if (variant.getImage_url3d() != null && !variant.getImage_url3d().isEmpty()) {
                try {
                    s3FileService.deleteFile(variant.getImage_url3d());
                } catch (Exception e) {
                    // Log the error but continue with the database update
                    System.err.println("Error deleting file from S3: " + e.getMessage());
                }
            }
            
            // Remove the 3D image URL from the database
            variant.setImage_url3d(null);
            productVariantService.save(variant);
            
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
    
    // Method to handle 3D model upload from API response
    @PostMapping("upload3DModel")
    @ResponseBody
    public ResponseEntity<?> upload3DModel(@RequestParam("file") MultipartFile file) {
        try {
            System.out.println("=== Starting 3D model upload from API response ===");
            
            if (file == null || file.isEmpty()) {
                System.out.println("Error: File is null or empty");
                return ResponseEntity.badRequest().body("File is null or empty");
            }
            
            System.out.println("File details - Size: " + file.getSize() + " bytes, Content Type: " + file.getContentType());
            
            // Generate a unique filename
            String originalFilename = file.getOriginalFilename();
            if (originalFilename == null) {
                originalFilename = "model_3d.glb";
            }
            
            // Upload to S3 and get the URL
            System.out.println("Starting S3 upload for API-generated model...");
            String s3FileUrl = s3FileService.uploadFile(file, "3Dmodel/api_generated/");
            System.out.println("File successfully uploaded to S3: " + s3FileUrl);
            
            // Return the URL of the uploaded file
            return ResponseEntity.ok().body("{\"modelUrl\": \"" + s3FileUrl + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error during API model upload: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
        }
    }
    
    // Method to update variant with 3D image URL
    @PostMapping("update3DImage")
    @ResponseBody
    public ResponseEntity<?> update3DImage(@RequestBody UpdateVariant3DImageRequest request) {
        try {
            System.out.println("=== Updating variant with 3D image URL ===");
            System.out.println("VariantId: " + request.getVariantId());
            System.out.println("Image URL 3D: " + request.getImage_url3d());
            
            ProductVariant variant = productVariantService.findById(request.getVariantId());
            if (variant == null) {
                System.out.println("Error: Variant not found for ID " + request.getVariantId());
                return ResponseEntity.badRequest().body("Variant not found");
            }
            
            // If there's an existing 3D image URL, delete it from S3
            if (variant.getImage_url3d() != null && !variant.getImage_url3d().isEmpty()) {
                try {
                    System.out.println("Deleting previous file: " + variant.getImage_url3d());
                    s3FileService.deleteFile(variant.getImage_url3d());
                } catch (Exception e) {
                    // Log the error but continue with the update
                    System.err.println("Error deleting previous file: " + e.getMessage());
                }
            }
            
            // Save the URL to the database
            variant.setImage_url3d(request.getImage_url3d());
            productVariantService.save(variant);
            System.out.println("Database updated with new 3D image URL");
            
            return ResponseEntity.ok().body("{\"success\": true, \"message\": \"3D image URL updated successfully\"}");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error updating 3D image URL: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
        }
    }
    
    // Request class for update3DImage
    public static class UpdateVariant3DImageRequest {
        private Integer variantId;
        private String image_url3d;
        
        public Integer getVariantId() {
            return variantId;
        }
        
        public void setVariantId(Integer variantId) {
            this.variantId = variantId;
        }
        
        public String getImage_url3d() {
            return image_url3d;
        }
        
        public void setImage_url3d(String image_url3d) {
            this.image_url3d = image_url3d;
        }
    }
    
    // Global exception handler for this controller
    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleException(Exception e) {
        e.printStackTrace();
        System.err.println("Global error handling: " + e.getMessage());
        return new ResponseEntity<>("Server error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
    }
}



