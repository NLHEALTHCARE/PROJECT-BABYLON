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
| - \(weglaten want ZIB met FHIR vergelijken en niet anddersom\) | Period |

\* Staat bij de Resource Patient als onderdeel.

In het onderdeel 'Naamgegevens' zijn de velden 'Voornaam', 'Initialen' en 'Roepnaam' bij ZIB hetzelfde als het veld 'given' bij FHIR. Bij 'given' is het mogelijk om vrije tekst in te vullen, hierdoor komt het in ZIB overeen met drie verschillende velden. Om het verschil tussen deze velden te onderscheiden kan worden gekeken in de code hoe 'given' wordt gerepresenteerd. In de meeste gevallen is 'given' de 'Voornaam' en dat kan via deze code worden toegewezen:

```
var patient, voornaam;

patient = {
             "name": [ { "use": "official",
                         "family": [ "Levin" ],
                         "given": [ "Henry" ]
                     } ]
          }

voornaam = patient.name[0].given;
```

Wanneer bij FHIR in het veld 'given' een punt \('.'\) voorkomt dan is dit in ZIB een initiaal van een naam. Dit kan gecontroleerd worden via deze code:

```
var patient, naamPatient, initialen, naam;

patient = {
             "name": [ { "use": "official",
                         "family": [ "Donald" ],
                         "given": [ "D." ]
                     } ]
          }

naamPatient = patient.name[0].given;
          
if (naamPatient.search("\\.") >= 1)
{
    initialen = patient.name[0].given;
}

else
{
    naam = patient.name[0].given;
}
```


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

| [ZIB Concept AdresGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR Address](https://www.hl7.org/fhir/datatypes.html#Address) |
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

### ContactGegevens

| [ZIB Concept ContactGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR Patient\(telecom\)](https://www.hl7.org/fhir/datatypes.html#HumanName)\* |
| :--- | :--- |
| Telefoonnummers | system(telecom) |
| EmailAdressen | system(telecom) |

\* Valt onder het onderdeel 'telecom' bij Resource Patient. \(Via verwijzing of erachter met "\(\)"\)

Net als bij het onderdeel 'Naamgegevens' verwijzen de velden 'Telefoonnummer' en 'EmailAdressen' naar hetzelfde veld in FHIR, namelijk het veld 'system'. In de code van FHIR kan worden gelezen om wat voor soort contactgegeven het gaat, in onderstaande code kan wordt bepaalt of het om een telefoonnummer of emailadres gaat:

```
var contactGegevens, contactSoort, telefoonNummer, emailAdres;

contactGegevens = {
                    "resourceType" : "ContactPoint",
                    "system" : "phone",
                    "value" : "(555) 675 5745",
                    "use" : "home"
                  }
contactSoort = contactGegevens.system;

if (contactSoort.search("phone") == 0)
{
    telefoonNummer = contactGegevens.system;
}

else if (contactSoort.search("email") == 0)
{
    emailAdres = contactGegevens.system;
}
```

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



