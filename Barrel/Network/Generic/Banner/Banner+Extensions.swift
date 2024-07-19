//
//  Banner+Extensions.swift
//  Ocerall
//
//  Created by KaayZenn on 27/06/2024.
//

import Foundation

extension Banner {
    struct NetworkError {
        
        static var badRequestError: Banner {
            return Banner(title: "networkError_400".localized, style: .error)
        }
        
        static var unauthorizedError: Banner {
            return Banner(title: "networkError_401".localized, style: .error)
        }
        
        static var notFoundError: Banner {
            return Banner(title: "networkError_404".localized, style: .error)
        }
            
        static var fieldIsIncorrectlyFilledError: Banner {
            return Banner(title: "networkError_422".localized, style: .error)
        }
        
        static var internalError: Banner {
            return Banner(title: "networkError_500".localized, style: .error)
        }
        
        static var parsingError: Banner {
            return Banner(title: "networkError_parsing".localized, style: .error)
        }
        
        static var refreshTokenFailedError: Banner {
            return Banner(title: "networkError_refreshToken".localized, style: .error)
        }
        
        static var noConnectionError: Banner {
            return Banner(title: "banner_error_noConnection".localized, style: .error)
        }
        
        static var unknownError: Banner {
            return Banner(title: "networkError_unknown".localized, style: .error)
        }
    }
}

// MARK: - Register Error
extension Banner {
    static var firstNameError: Banner {
        return Banner(title: "banner_error_firstName".localized, style: .error)
    }
    
    static var lastNameError: Banner {
        return Banner(title: "banner_error_lastName".localized, style: .error)
    }
    
    static var userNameError: Banner {
        return Banner(title: "banner_error_userName".localized, style: .error)
    }
    
    static var emailError: Banner {
        return Banner(title: "banner_error_email".localized, style: .error)
    }
    
    static var passwordError: Banner {
        return Banner(title: "banner_error_password".localized, style: .error)
    }
    
    static var confirmPasswordError: Banner {
        return Banner(title: "banner_error_confirmPassword".localized, style: .error)
    }
    
    static var usernameInvalid: Banner {
        return Banner(title: "banner_422_username_invalid".localized, style: .error)
    }
    
    static var emailInvalid: Banner {
        return Banner(title: "banner_422_email_invalid".localized, style: .error)
    }
}
