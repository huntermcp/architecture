module "aws_cognito_user_pool_hunterthomasinc" {

  source = "../../modules/terraform-aws-cognito-user-pool"

  user_pool_name             = "hunterthomasinc.com"
  alias_attributes           = ["email", "phone_number"]
  auto_verified_attributes   = ["email"]
  # sms_authentication_message = "Your username is {username} and temporary password is {####}."
  sms_verification_message   = "This is the verification message {####}."
  
  mfa_configuration = "OPTIONAL"
  software_token_mfa_configuration = {
    enabled = true
  }

  admin_create_user_config = {
    email_message = "Dear {username}, your verification code is {####}."
    email_subject = "Your verification code for hunterthomasinc.com"
    sms_message   = "Your username is {username} and temporary password is {####}."
  }

  device_configuration = {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = true
  }

  #email_configuration = {
  #  email_sending_account  = "DEVELOPER"
  #  reply_to_email_address = "email@mydomain.com"
  #  source_arn             = "arn:aws:ses:us-east-1:123456789012:identity/myemail@mydomain.com"
  #}

  lambda_config = {
    #create_auth_challenge          = "arn:aws:lambda:us-east-1:123456789012:function:create_auth_challenge"
    ##custom_message                 = "arn:aws:lambda:us-east-1:123456789012:function:custom_message"
    #define_auth_challenge          = "arn:aws:lambda:us-east-1:123456789012:function:define_auth_challenge"
    #post_authentication            = "arn:aws:lambda:us-east-1:123456789012:function:post_authentication"
    #post_confirmation              = "arn:aws:lambda:us-east-1:123456789012:function:post_confirmation"
    #pre_authentication             = "arn:aws:lambda:us-east-1:123456789012:function:pre_authentication"
    #pre_sign_up                    = "arn:aws:lambda:us-east-1:123456789012:function:pre_sign_up"
    #pre_token_generation           = "arn:aws:lambda:us-east-1:123456789012:function:pre_token_generation"
    #user_migration                 = "arn:aws:lambda:us-east-1:123456789012:function:user_migration"
    #verify_auth_challenge_response = "arn:aws:lambda:us-east-1:123456789012:function:verify_auth_challenge_response"
    #kms_key_id                     = aws_kms_key.lambda-custom-sender.arn
    #custom_email_sender = {
    ##  lambda_arn     = "arn:aws:lambda:us-east-1:123456789012:function:custom_email_sender"
    #  lambda_version = "V1_0"
    #}
    #custom_sms_sender = {
    #  lambda_arn     = "arn:aws:lambda:us-east-1:123456789012:function:custom_sms_sender"
    #  lambda_version = "V1_0"
    #}
  }

  password_policy = {
    minimum_length                   = 10
    require_lowercase                = false
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 120

  }

  user_pool_add_ons = {
    advanced_security_mode = "ENFORCED"
  }

  verification_message_template = {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  schemas = [
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = false
      mutable                  = true
      name                     = "available"
      required                 = false
    },
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = true
      mutable                  = true
      name                     = "registered"
      required                 = false
    },
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = true
      mutable                  = true
      name                     = "admin"
      required                 = false
    }
  ]

  string_schemas = [
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = false
      name                     = "email"
      required                 = true

      string_attribute_constraints = {
        min_length = 3
        max_length = 100
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "organization"
      required                 = false

      string_attribute_constraints = {
                min_length = 2
        max_length = 100
       }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "org"
      required                 = false

      string_attribute_constraints = {
                min_length = 2
        max_length = 100
       }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "role"
      required                 = false

      string_attribute_constraints = { 
                min_length = 3
        max_length = 100
      }
    },
  ]

  number_schemas = []

  # user_pool_domain
  #domain = "auth.hunterthomasinc.com"
  #domain_certificate_arn = "arn:aws:acm:us-east-1:308661681515:certificate/ecfa929a-fadb-4a37-9734-bc3802f160c4"

  # clients
  clients = [
    {
      allowed_oauth_flows                  = ["code", "implicit"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["email", "openid"]
      callback_urls                        = ["https://auth.hunterthomasinc.com/", "https://hunterthomasinc.com/"]
      default_redirect_uri                 = "https://hunterthomasinc.com/"
      explicit_auth_flows                  = ["CUSTOM_AUTH_FLOW_ONLY", "ADMIN_NO_SRP_AUTH",]
      generate_secret                      = false
      logout_urls                          = ["https://hunterthomasinc.com/logout"]
      name                                 = "frontend_app"
      enable_propagate_additional_user_context_data = false
      read_attributes                      = [
        "email", "address", "birthdate",
         "custom:organization",
         "custom:role",
         "email_verified",
         "family_name",
         "gender",
         "given_name",
         "locale",
         "middle_name",
         "name",
         "nickname",
         "phone_number",
         "phone_number_verified",
         "picture",
         "preferred_username",
         "profile",
         "updated_at",
         "website",
         "zoneinfo"
      
      ]
      supported_identity_providers         = []
      write_attributes                     = [
        "address",
         "birthdate",
         "custom:organization",
         "custom:role",
         "email",
         "family_name",
         "gender",
         "given_name",
         "locale",
         "middle_name",
         "name",
         "nickname",
         "phone_number",
         "picture",
         "preferred_username",
         "profile",
         "updated_at",
         "website",
         "zoneinfo",
      ]
      access_token_validity                = 15
      id_token_validity                    = 15
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
  ]

  # user_group
  user_groups = [
    { name        = "initial_group"
      description = "First Group"
    }
  ]

  # resource_servers
  resource_servers = [
    {
      identifier = "https://api.hunterthomasinc.com"
      name       = "hunterthomasinc API"
      scope = [
        {
          scope_name        = "staker.read"
          scope_description = "GET access for API"
        },
        #{
        #  scope_name        = "user.write"
        #  scope_description = "POST access for API"
        #},
      ]
    }
  ]

  # identity_providers
  identity_providers = []

  # tags
  tags = {
    Owner       = "Hunter"
    Environment = "dev"
    Terraform   = true
  }
}


# KMS key for lambda custom sender config"
resource "aws_kms_key" "lambda-custom-sender" {
  description = "KMS key for lambda custom sender config"
}
