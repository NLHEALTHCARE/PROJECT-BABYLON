# Concepten van de bouwsteen [patiënt](/bouwsteen/patient/bouwsteen-patient.md)

### Naamgegevens

| [ZIB onderdeel Naamgegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR Name](https://www.hl7.org/fhir/datatypes.html#HumanName) |
| :--- | :--- |
| Voornaam | given |
| Initialen | given |
| Roepnaam | given |
| Naamgebruik | use |
| Geslachtsnaam | family |
| GeslachtsnaamPartner |  |
| - | Period |

#### Geslachtsnaam

| [ZIB Onderdeel geslachtsnaam](https://zibs.nl/wiki/Patient(NL) | [FHIR patient](https://www.hl7.org/fhir/datatypes.html#HumanName) |
| :--- | :--- |
| Voorvoegesels | family |
| Achternaam | family |

#### GeslachtsnaamPartner

| [ZIB Onderdeel geslachtsnaampartner](https://zibs.nl/wiki/Patient(NL) | [FHIR Patient\(Contact\)](https://www.hl7.org/fhir/datatypes.html#HumanName)\* |
| :--- | :--- |
| VoorvoegeselsPartner | family |
| Achternaampartner | family |

\* Valt onder het onderdeel 'contact' bij Resource Patient. \(Via verwijzing of erachter met "\(\)"\)

### AdresGegevens

| [ZIB](https://zibs.nl/wiki/Patient(NL) | [FHIR](https://www.hl7.org/fhir/datatypes.html#HumanName) |
| :--- | :--- |
| Voornaam | given |
| Initialen | given |
| Roepnaam | given |
| Naamgebruik | use |
| Geslachtsnaam | family |
| GeslachtsnaamPartner | - |
| - | Period |

###ContactGegevens

| [ZIB Onderdeel ContactGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR Patient\(telecom\)](https://www.hl7.org/fhir/datatypes.html#HumanName)\* |
| :--- | :--- |
| Telefoonnummers | telecom |
| EmailAdressen | telecom |

\* Valt onder het onderdeel 'telecom' bij Resource Patient. \(Via verwijzing of erachter met "\(\)"\)

#### Telefoonnummers

| [ZIB Onderdeel ContactGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR ContactPoint](https://www.hl7.org/fhir/datatypes.html#ContactPoint) |
| :--- | :--- |
| Telefoonnummers | telecom |
| EmailAdressen | telecom |



