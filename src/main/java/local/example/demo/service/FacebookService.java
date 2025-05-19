package local.example.demo.service;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletContext;
import local.example.demo.model.dto.facebook.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Service;

import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.io.FilenameUtils;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;
import java.util.*;

@Service
public class FacebookService {
    private String pageId ;
    private String accessToken ;
    @Autowired
    private ImageDownloadService imageDownloadService;

    private final ServletContext servletContext;

    public FacebookService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public List<Post> getPosts() {
        List<Post> posts = new ArrayList<>();
        try {
            String url = "https://graph.facebook.com/" + pageId + "/posts?fields=id,message,created_time,attachments{media,type,url},permalink_url&access_token=" + accessToken;

            RestTemplate restTemplate = new RestTemplate();
            ObjectMapper mapper = new ObjectMapper();
            JsonNode dataNode = restTemplate.getForObject(url, JsonNode.class).get("data");

            if (dataNode.isArray()) {
                for (JsonNode node : dataNode) {
                    Post post = mapper.treeToValue(node, Post.class);

                    if (post.getAttachments() != null && post.getAttachments().getData() != null) {
                        for (AttachmentData attachment : post.getAttachments().getData()) {
                            if ("photo".equals(attachment.getType())) {
                                String imageUrl = imageDownloadService.downloadFacebookImage(attachment.getMedia().getImage().getSrc());
                                if (imageUrl != null && !imageUrl.isEmpty()) {
                                    try {
                                        String fileName = "fb_" + UUID.randomUUID() + ".jpg";
                                        String uploadDir = servletContext.getRealPath("/resources/images-upload/facebook/");
                                        File directory = new File(uploadDir);
                                        if (!directory.exists()) {
                                            directory.mkdirs();
                                        }

                                        BufferedImage image = ImageIO.read(new URL(imageUrl));
                                        File outputFile = new File(uploadDir, fileName);
                                        ImageIO.write(image, "jpg", outputFile);

                                        attachment.setLocalImage("/resources/images-upload/facebook/" + fileName);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        }
                    }

                    posts.add(post);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return posts;
    }

    public String postTextToFacebook(String message) {
        try {
            String url = "https://graph.facebook.com/" + pageId + "/feed";

            Map<String, String> params = new HashMap<>();
            params.put("message", message);
            params.put("access_token", accessToken);

            RestTemplate restTemplate = new RestTemplate();
            return restTemplate.postForObject(url, params, String.class);
        } catch (Exception e) {
            return "Error posting text: " + e.getMessage();
        }
    }

    public String postPhotoToFacebook(String message, MultipartFile file) {
        try {
            String uploadDir = servletContext.getRealPath("/resources/images-upload/facebook/");
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            String fileName = UUID.randomUUID() + "." + FilenameUtils.getExtension(file.getOriginalFilename());
            File dest = new File(uploadDir, fileName);
            file.transferTo(dest);

            String uploadUrl = "https://graph.facebook.com/" + pageId + "/photos";
            Map<String, Object> body = new LinkedHashMap<>();
            body.put("message", message);
            body.put("access_token", accessToken);
            body.put("source", new FileSystemResource(dest));

            RestTemplate restTemplate = new RestTemplate();
            return restTemplate.postForObject(uploadUrl, body, String.class);
        } catch (Exception e) {
            return "Error posting image: " + e.getMessage();
        }
    }
}
