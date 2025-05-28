package local.example.demo.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;
import java.util.zip.GZIPOutputStream;

@Service
public class S3FileService {

    private final String accessKey = "";
    private final String secretKey = "";
    private final String region = "";
    private final String bucketName = ""; // Your bucket name

    private AmazonS3 s3Client;

    public S3FileService() {
        BasicAWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
        s3Client = AmazonS3ClientBuilder
                .standard()
                .withRegion(Regions.fromName(region))
                .withCredentials(new AWSStaticCredentialsProvider(credentials))
                .build();
    }

    /**
     * Upload a file to AWS S3
     * 
     * @param file       The file to upload
     * @param folderName The folder name to save the file (e.g., "3Dmodel/")
     * @return The URL of the uploaded file
     * @throws IOException If an I/O error occurs
     */
    public String uploadFile(MultipartFile file, String folderName) throws IOException {
        // Generate a unique file name to avoid collisions
        String originalFileName = file.getOriginalFilename();
        String extension = "";
        boolean isGlbFile = false;

        if (originalFileName != null && originalFileName.contains(".")) {
            extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            isGlbFile = extension.equalsIgnoreCase(".glb");
        }

        String fileName = folderName + UUID.randomUUID().toString() + extension;

        // Prepare metadata
        ObjectMetadata metadata = new ObjectMetadata();

        // Process file content - compress GLB files
        InputStream fileInputStream;
        long contentLength;

        if (isGlbFile) {
            // Compress GLB file with GZIP
            byte[] compressedContent = compressWithGzip(file.getBytes());
            fileInputStream = new ByteArrayInputStream(compressedContent);
            contentLength = compressedContent.length;

            // Set content encoding to indicate compression
            metadata.setContentEncoding("gzip");
            System.out.println("GLB file compressed: Original size = " + file.getSize() + " bytes, Compressed size = "
                    + contentLength + " bytes");
        } else {
            // Other file types - no compression
            fileInputStream = file.getInputStream();
            contentLength = file.getSize();
        }

        metadata.setContentType(file.getContentType());
        metadata.setContentLength(contentLength);

        // Upload file to S3 without setting ACL (bucket has ACLs disabled)
        PutObjectRequest putObjectRequest = new PutObjectRequest(
                bucketName,
                fileName,
                fileInputStream,
                metadata);

        s3Client.putObject(putObjectRequest);

        // Return the public URL
        return s3Client.getUrl(bucketName, fileName).toString();
    }

    /**
     * Compress data using GZIP
     * 
     * @param data The data to compress
     * @return Compressed data
     * @throws IOException If an I/O error occurs
     */
    private byte[] compressWithGzip(byte[] data) throws IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream(data.length);

        try (GZIPOutputStream gzipOutputStream = new GZIPOutputStream(byteArrayOutputStream)) {
            gzipOutputStream.write(data);
        }

        return byteArrayOutputStream.toByteArray();
    }

    /**
     * Delete a file from AWS S3
     * 
     * @param fileUrl The URL of the file to delete
     */
    public void deleteFile(String fileUrl) {
        try {
            // Extract the key from the URL
            String key = fileUrl.substring(fileUrl.indexOf(bucketName) + bucketName.length() + 1);

            // Delete the file
            s3Client.deleteObject(bucketName, key);
            System.out.println("Successfully deleted file: " + key);
        } catch (Exception e) {
            System.err.println("Error deleting file from S3: " + e.getMessage());
        }
    }
}