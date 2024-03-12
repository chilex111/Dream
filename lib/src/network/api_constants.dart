class ApiConstants{
  static String baseUrl = '';

  ///misc
  static String countries = '/countries';
  static String states = '/states';
  static String lga = '/lgas';

  ///auth
  static String signUp = '/auth/user/register';
  static String signUpCompany = '/auth/company/register';
  static String login = '/auth/login';
  static String verifyEmail = '/auth/user/verify';
  static String googleLogin = '/auth/google/verify';
  static String forgotPassword = '/forgot-password';
  static String refresh = '/refresh';

  ///profile
  static String users = '/users';
  static String setUpProfileIndividual = '/users/setup/individual';
  static String setUpProfileCompany = '/users/setup/company';
  static String setupKYCIndividual = '/users/kyc/individual';
  static String setupKYCCompany = '/users/kyc/company';
  static String setupKYCIndividualUploadDocs = '/users/kyc/individual/upload';
  static String updateProfile = '/users/update/profile';
  static String updateNextOfKin = '/users/update-nextofkin/';
  static String updateCompanyProfile = '/users/update-company/';
  static String updateCompanyContactPerson = '/users/update-company-owner/';

  ///property
  static String amenities = '/amenities';
  static String propertyTypes = '/property-types';
  static String property = '/properties';
  static String propertyMarketPlace = '/properties/marketplace';
  static String baseRecords = '/properties/base-records';
  static String propertyStatusCount = '/properties/status-count/';
  static String propertyUploader = '/properties/uploader';
  static String propertyTitleDeed = '/title_deed/mobile';

  ///claims
  static String claimRequest = '/claim-requests';

  ///Invoice
  static String userInvoice = '/invoice/user';
  static String sellerInvoice = '/invoice/seller';
  static String invoice = '/invoice';
  static String invoicePayment = '/invoice/payments';
  static String createPurchaseInvoice = '/invoice/create/purchase_invoice';
  static String invoiceByProperty = '/invoice/fetch_by_property';
  static String invoiceMakePayment = '/invoice/payment/create';
  static String invoiceVerifyPayment = '/invoice/payment/detail/';

  static String accountAlreadyExist= 'The account already exists with a different credential';
  static String errorAccessingCredentials = 'Error occurred while accessing credentials. Try again.';
  static String errorWithGoogleSignIn = 'Error occurred using Google Sign In. Try again.';

  ///Company
  static String companyTypes = '/company-types';

  ///messages
  static String message = '/message';

  ///biding
  static String biding = '/biding';

  ///notifications
  static String notifications = '/notifications';
}