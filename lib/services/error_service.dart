class ErrorService {
  static final Map<String, String> _firebaseAuthErrorMessages = {
    'user-not-found': 'Korisnik ne postoji u našoj bazi podataka.',
    'invalid-email':
        'E-mail koji ste unijeli nije ispravnog formata. Unesite ispravan e-mail pa pokušajte ponovo.',
    'permission-denied':
        'Pristupn zabranjen. Nemate dozvolu za izvršavanje ove radnje.',
    'storage/unauthorized':
        'Pristupn zabranjen. Nemate dozvolu za izvršavanje ove radnje.',
    'unauthorized':
        'Pristupn zabranjen. Nemate dozvolu za izvršavanje ove radnje.',
    'storage/object-not-found': 'Fajl nije pronađen ili je obrisan.',
    'wrong-password': 'Lozinka koju ste unijeli je netačna. Pokušajte ponovo.',
    'weak-password':
        'Lozinka koju ste unijeli je preslaba. Minimalna dužina lozinke je 6 slova.',
    'email-already-in-use':
        'Mejl koji ste unijeli je zauzet. Probajte ponovo sa nekim durgim mejlom.',
  };

  static String getErrorMessage(
    String _errorCode,
  ) =>
      _firebaseAuthErrorMessages.containsKey(_errorCode)
          ? _firebaseAuthErrorMessages[_errorCode]
          : '$_errorCode';
}
