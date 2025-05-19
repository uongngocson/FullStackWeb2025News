package local.example.demo.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public  class FacebookPost {
        private String id;
        private String message;
        private String createdTime;
        private String permalinkUrl;
        private String localImagePath;
}
