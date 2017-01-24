# Concepten van de bouwsteen [patiënt](/bouwsteen/patient/bouwsteen-patient.md)

### Naamgegevens

| [ZIB Concept Naamgegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR Name](https://www.hl7.org/fhir/datatypes.html#HumanName) |
| :--- | :--- |
| Voornaam | given |
| Initialen | given |
| Roepnaam | given |
| Naamgebruik | use |
| Geslachtsnaam | family |
| GeslachtsnaamPartner | contact\* |
| - (weglaten want ZIB met FHIR vergelijken en niet anddersom) | Period |

\* Staat bij de Resource Patient als onderdeel.

* ##### Geslachtsnaam

| [ZIB Concept geslachtsnaam](https://zibs.nl/wiki/Patient(NL) | [FHIR Name](https://www.hl7.org/fhir/datatypes.html#HumanName) |
| :--- | :--- |
| Voorvoegesels | family |
| Achternaam | family |


* ##### GeslachtsnaamPartner

| [ZIB Concept geslachtsnaampartner](https://zibs.nl/wiki/Patient(NL) | [FHIR Patient\(Contact/name\)](https://www.hl7.org/fhir/datatypes.html#HumanName)\* |
| :--- | :--- |
| VoorvoegeselsPartner | family |
| Achternaampartner | family |

\* Valt onder het onderdeel 'contact' bij Resource Patient. \(Via verwijzing of erachter met "\(\)"\)

### AdresGegevens

| [ZIB Concept AdresGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR Address](https://www.hl7.org/fhir/datatypes.html#Address)|
| :--- | :--- |
| Straat | line |
| Huisnummer | line |
| Huisnummerletter | line |
| Huisnummertoevoeging | line |
| AanduidingBijNummer | line |
| Postcode | postalCode |
| Woonplaats | city |
| Gemeente | district |
| Land | country |
| AdditioneleInformatie |  |
| AdresSoort | use |

###ContactGegevens

| [ZIB Concept ContactGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR Patient\(telecom\)](https://www.hl7.org/fhir/datatypes.html#HumanName)\* |
| :--- | :--- |
| Telefoonnummers | telecom |
| EmailAdressen | telecom |

\* Valt onder het onderdeel 'telecom' bij Resource Patient. \(Via verwijzing of erachter met "\(\)"\)
 

* ##### Telefoonnummers

| [ZIB Concept ContactGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR ContactPoint](https://www.hl7.org/fhir/datatypes.html#ContactPoint) |
| :--- | :--- |
| Telefoonnummers | value |
| Nummersoort | use |


* ##### EmailAdressen

| [ZIB Concept ContactGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR ContactPoint](https://www.hl7.org/fhir/datatypes.html#ContactPoint) |
| :--- | :--- |
| EmailAdres | value |
| EmailSoort | use |



