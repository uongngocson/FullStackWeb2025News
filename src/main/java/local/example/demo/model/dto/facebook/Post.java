package local.example.demo.model.dto.facebook;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Post {
    private String id;
    private String message;
    private String created_time;
    private Attachments attachments;
    private String permalink_url;
}
