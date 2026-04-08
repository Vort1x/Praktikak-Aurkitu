# Spécifications des APIs pour l'application "praktikak aurkitu"

## 1. API Apprentissage (La Bonne Alternance)
- **Base URL** : `https://api.apprentissage.beta.gouv.fr/v1`
- **Endpoint Recherche** : `GET /job/v1/search`
- **Paramètres Clés** :
    - `caller` : Identifiant de l'appelant (requis).
    - `latitude`, `longitude` : Coordonnées pour la recherche géographique.
    - `radius` : Rayon de recherche en km.
    - `rome` : Codes ROME (métiers).
    - `sources` : `offres_emploi_lba`, `offres_emploi_partenaires`, `recruteurs_lba`.
- **Authentification** : Optionnelle pour la recherche (souvent via `api-key` dans les headers si quota élevé requis).

## 2. APIs France Travail
- **Authentification** : OAuth2 Client Credentials.
    - **Token URL** : `https://entreprise.pole-emploi.fr/connexion/oauth2/access_token?realm=/partenaire`
    - **Grant Type** : `client_credentials`
    - **Scope** : `api_offresemploisv2`, `api_mes-evenements-emploi-v1`, etc.
- **Endpoint Offres d'emploi v2** : `https://api.francetravail.io/partenaire/offresdemploi/v2/offres/search`
- **Rate Limiting** : 
    - Offres : 10 appels/sec.
    - Événements : 10 appels/sec.
    - Pages employeurs : 50 appels/sec.

## 3. Structure des données (Classes)
- `JobOffer` : Titre, Entreprise, Lieu, Type de contrat, Description, Lien postuler.
- `Event` : Titre, Date, Lieu, Description.
