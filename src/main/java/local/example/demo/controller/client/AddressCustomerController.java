package local.example.demo.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import local.example.demo.service.AddressService;
import local.example.demo.service.CustomerService;
import lombok.extern.slf4j.Slf4j;

/**
 * This controller's functionality has been migrated to GiaohangnhanhController.
 * It remains as a placeholder to avoid breaking any existing references.
 */
@Controller
@Slf4j
public class AddressCustomerController {

    @Autowired
    private AddressService addressService;
    
    @Autowired
    private CustomerService customerService;
    
    /**
     * Redirects to the new implementation in GiaohangnhanhController
     */
    @GetMapping("/address/customer")
    public String getCustomerAddress() {
        return "redirect:/order/orderfix";
    }
} 