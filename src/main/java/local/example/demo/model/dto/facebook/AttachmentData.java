package local.example.demo.model.dto.facebook;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachmentData {
    private Media media;
    private String type;
    private String url;
    private String localImage;
}
