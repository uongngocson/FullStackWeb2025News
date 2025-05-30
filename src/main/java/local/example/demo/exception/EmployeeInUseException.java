package local.example.demo.exception;

public class EmployeeInUseException extends RuntimeException {
    public EmployeeInUseException(String message) {
        super(message);
    }
}
