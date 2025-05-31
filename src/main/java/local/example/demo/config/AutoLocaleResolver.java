package local.example.demo.config;

import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import jakarta.servlet.http.HttpServletRequest;

/**
 * Custom LocaleResolver that automatically detects the user's preferred language
 * from browser settings and falls back to supported languages
 */
public class AutoLocaleResolver extends SessionLocaleResolver {
    
    // List of supported locales in the application
    private static final List<Locale> SUPPORTED_LOCALES = Arrays.asList(
        new Locale("en"),  // English
        new Locale("vi")   // Vietnamese
    );
    
    // Default locale if no match is found
    private static final Locale DEFAULT_LOCALE = Locale.ENGLISH;
    
    @Override
    public Locale resolveLocale(HttpServletRequest request) {
        // First check if there's a locale in the session (user already selected)
        Locale sessionLocale = (Locale) request.getSession().getAttribute(LOCALE_SESSION_ATTRIBUTE_NAME);
        if (sessionLocale != null) {
            return sessionLocale;
        }
        
        // Check if there's a lang parameter in the URL (explicit selection)
        String langParam = request.getParameter("lang");
        if (langParam != null && !langParam.isEmpty()) {
            Locale localeFromParam = new Locale(langParam);
            if (isSupportedLocale(localeFromParam)) {
                return localeFromParam;
            }
        }
        
        // Get browser's preferred locales
        Locale preferredLocale = request.getLocale();
        if (preferredLocale != null && isSupportedLocale(preferredLocale)) {
            return preferredLocale;
        }
        
        // If no match found, return default locale
        return DEFAULT_LOCALE;
    }
    
    private boolean isSupportedLocale(Locale locale) {
        return SUPPORTED_LOCALES.stream()
                .anyMatch(supportedLocale -> 
                    supportedLocale.getLanguage().equals(locale.getLanguage()));
    }
} 