package local.example.demo.service;

import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.*;
import java.util.UUID;

@Service
public class ImageDownloadService {

    private static final String IMAGE_DIR = "images/facebook";

    public String downloadFacebookImage(String imageUrlStr) {
        try {
            // Tạo folder nếu chưa có
            Path imageDirPath = Paths.get(IMAGE_DIR);
            if (Files.notExists(imageDirPath)) {
                Files.createDirectories(imageDirPath);
            }

            // Tạo file name có đuôi .jpg
            String fileName = UUID.randomUUID().toString() + ".jpg";
            Path outputPath = imageDirPath.resolve(fileName);

            // Kết nối HTTP với headers để tránh bị 403
            URL imageUrl = new URL(imageUrlStr);
            HttpURLConnection connection = (HttpURLConnection) imageUrl.openConnection();
            connection.setRequestProperty("User-Agent", "Mozilla/5.0");
            connection.setRequestProperty("Referer", "https://www.facebook.com");
            connection.connect();

            if (connection.getResponseCode() == 200) {
                try (InputStream in = connection.getInputStream()) {
                    Files.copy(in, outputPath, StandardCopyOption.REPLACE_EXISTING);
                }

                // Trả về đường dẫn tương đối để render trong frontend
                return "/images/facebook/" + fileName;
            } else {
                System.err.println("Failed to download image: HTTP " + connection.getResponseCode());
                return null;
            }
        } catch (Exception e) {
            System.err.println("Error downloading image: " + e.getMessage());
            return null;
        }
    }
}
