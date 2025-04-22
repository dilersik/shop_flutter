class Constants {
  static const baseUrl = 'https://shop-flutter-8d4e3-default-rtdb.firebaseio.com';
  static const apiKey = 'AIzaSyAGZvMYXrwQ8cQDfQ27LZdgMbsVk0Y43x8'; // deleted
  // Realtime Firebase Database rules
// {
//   "rules": {
//     "orders": {
//       "$uid": {
//         ".write": "$uid === auth.uid",
//         ".read": "$uid === auth.uid",
//       },
//     },
//     "user-favorites": {
//       "$uid": {
//         ".write": "$uid === auth.uid",
//         ".read": "$uid === auth.uid",
//       },
//     },
//     "products": {
//       ".write": "auth != null",
//       ".read": "auth != null",
//     }
//   }
// }
  static const firebaseAuthUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const userFavoriteBaseUrl = '$baseUrl/user-favorites';
  static const productBaseUrl = '$baseUrl/products';
  static const ordersBaseUrl = '$baseUrl/orders';
  static const userDataPreference = 'userDataPreference';

}