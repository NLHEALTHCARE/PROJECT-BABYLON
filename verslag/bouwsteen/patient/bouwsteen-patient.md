# Patient

* Probleem links ZIB Patient
  * Link eindigt met "\(NL\)" en dit gaat fout.

### Concepten

| [ZIB Patiënt](https://zibs.nl/wiki/Patient(NL) | [FHIR Patiënt](https://www.hl7.org/fhir/patient.html) |
| :--- | :--- |
| PatientIdentificatieNummer | Identifier |
| Geboortedatum | birthDate |
| Geslacht | Gender |
| Meerling | multipleBirth |
| Naamgegevens \[[1](/bouwsteen/patient/patient-concepten.md)\] | Name |
| AdresGegevens \[[2](/bouwsteen/patient/patient-concepten.md)\] | address |
| ContactGegevens \[[3](/bouwsteen/patient/patient-concepten.md###ContactGegevens)\] | telecom |
| OverlijdingsIndicator | deceased |
| DatumOverlijden | deceased |

\[_\#_\] Bestaan uit meerdere onderdelen

### Datatypen

| Concept | ZIB Patiënt | FHIR Patiënt |
| :--- | :--- | :--- |
| PatientIdentificatieNummer | String | String |
| Geboortedatum | Timestamp | date |
| Geslacht | SNOMED-CT | Code |
| Meerling | boolean | Boolean/Integer |
| Naamgegevens | \[[1](/bouwsteen/patient/patient-concepten.md)\] |  |
| AdresGegevens | \[[2](/bouwsteen/patient/patient-concepten.md)\] |  |
| ContactGegevens | \[[3](/bouwsteen/patient/patient-concepten.md###ContactGegevens)\] |  |
| OverlijdingsIndicator | Boolean | Boolean |
| DatumOverlijden | Timestamp | dateTime |

* Idee --&gt; Concept wat meerdere onderdelen bevat als link neerzetten en verwijzen naar andere pagina waar deze weer worden vergeleken.

[dit is de tekst](http://kapitan.net)

dit heb ik online geedit

