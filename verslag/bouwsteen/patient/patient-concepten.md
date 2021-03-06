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

* Hierbij zelfde soort code gebruiken als bij 'Naamgegevens' en 'ContactGegevens' en line opsplitsen aan de hand van de regex. Dus online staat als voorbeeld het adres: "137 Nowhere Street". Via regex ((\d+)\s(\w+\s+\w+)) kan nummer eruit worden gehaald en de straat en dit opslaan in variabelen.

### ContactGegevens

| [ZIB Concept ContactGegevens](https://zibs.nl/wiki/Patient(NL) | [FHIR Patient\(telecom\)](https://www.hl7.org/fhir/datatypes.html#HumanName)\* |
| :--- | :--- |
| Telefoonnummers | system\(telecom\) |
| EmailAdressen | system\(telecom\) |

\* Valt onder het onderdeel 'telecom' bij Resource Patient. \(Via verwijzing of erachter met "\(\)"\)

Net als bij het onderdeel 'Naamgegevens' verwijzen de velden 'Telefoonnummer' en 'EmailAdressen' naar hetzelfde veld in FHIR, namelijk het veld 'system'. In de code van FHIR kan worden gelezen om wat voor soort contactgegeven het gaat, in onderstaande code kan wordt bepaalt of het om een telefoonnummer of emailadres gaat:

```
var contactGegevens, systeemSoort, contactSoort, telefoonNummer, emailAdres;

contactGegevens = {
                    "resourceType" : "ContactPoint",
                    "system" : "phone",
                    "value" : "(555) 675 5745",
                    "use" : "home"
                  }
systeemSoort = contactGegevens.system;

if (systeemSoort.search("phone") == 0)
{
    contactSoort = contactGegevens.system;
}

else if (systeemSoort.search("email") == 0)
{
    contactSoort = contactGegevens.system;
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

Ook bij de onderdelen 'Telefoonnummers' en 'EmailAdressen' zijn de velden in FHIR hetzelfde. Ook hierbij kan uit de code worden gelezen of het om een telefoonnummer of emailadres gaat, hieronder staat een voorbeeld van de code voor de velden bij het onderdeel 'Telefoonnummers':

```
var contactGegevens, systeemSoort, contactSoort, telefoonNummer, emailAdres;

contactGegevens = {
                    "resourceType" : "ContactPoint",
                    "system" : "phone",
                    "value" : "(555) 675 5745",
                    "use" : "home"
                  }
systeemSoort = contactGegevens.system;

if (systeemSoort.search("phone") == 0)
{
    contactSoort = contactGegevens.system;
}

else if (systeemSoort.search("email") == 0)
{
    contactSoort = contactGegevens.system;
}

telefoonNummer = contactGegevens.value;
```

In de code hieronder staat een voorbeeld wanneer het om een emailadres gaat:

```
var contactGegevens, systeemSoort, contactSoort, telefoonNummer, emailAdres;

contactGegevens = {
                    "resourceType" : "ContactPoint",
                    "system" : "email",
                    "value" : "example@hl7fhir.org",
                    "use" : "home"
                  }
systeemSoort = contactGegevens.system;

if (systeemSoort.search("phone") == 0)
{
    contactSoort = contactGegevens.system;
}

else if (systeemSoort.search("email") == 0)
{
    contactSoort = contactGegevens.system;
}

emailAdres = contactGegevens.value;
```



