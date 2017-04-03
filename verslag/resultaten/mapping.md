# Mapping van Zorginformatiebouwstenen naar FHIR

De mapping van de zorginformatiebouwstenen (zib) naar de FHIR-resources.

|[Zorginformatiebouwsteen](https://zibs.nl/wiki/Zorginformatiebouwstenen)|[FHIR Resource](https://www.hl7.org/fhir/resourcelist.html)|
|:---|:---|
| Alert | [Flag](https://www.hl7.org/fhir/flag.html) |
| FunctioneleOfMentaleStatus | [Observation](https://www.hl7.org/fhir/observation.html) |
| Familieanamnese | [FamilyMemberHistory](https://www.hl7.org/fhir/familymemberhistory.html) |
| BarthelIndex | [Observation](https://www.hl7.org/fhir/observation.html) |
| BehandelAanwijzing | [CarePlan](https://www.hl7.org/fhir/careplan.html) |
| OverdrachtGeplandeZorgActiviteit | [ProcedureRequest](https://www.hl7.org/fhir/procedurerequest.html) / [ReferralRequest](https://www.hl7.org/fhir/referralrequest.html) |
| OverdrachtConcern | [Condition](https://www.hl7.org/fhir/condition.html) |
| MedischHulpmiddel | [Device](https://www.hl7.org/fhir/device.html) |
| MedicatieVerstrekking | [MedicationStatement](https://www.hl7.org/fhir/medicationstatement.html) |
| MedicatieVoorschrift | [MedicationRequest](https://www.hl7.org/fhir/medicationrequest.html) |
| MedicatieToediening | [MedicationAdministration](https://www.hl7.org/fhir/medicationadministration.html) |
| Vaccinatie | [Immunization](https://www.hl7.org/fhir/immunization.html) |
| AllergieIntolerantie | [AllergyIntolerance](https://www.hl7.org/fhir/allergyintolerance.html) |
| Betaler | [Claim]()/[Coverage](https://www.hl7.org/fhir/coverage.html) |
| Wilsverklaring | [Consent](https://www.hl7.org/fhir/consent.html) |
| Levensovertuiging | [Patient-religion]() |
| Nationaliteit | [Patient-nationality]() |
| Contact | [Encounter](https://www.hl7.org/fhir/encounter.html) |
| Woonsituaie | [Patient](https://www.hl7.org/fhir/patient.html) |
| BurgelijkeStaat | [Patient](https://www.hl7.org/fhir/patient.html) |
| Contactpersoon | [RelatedPerson](https://www.hl7.org/fhir/relatedperson.html) |
| Zorgaanbieder | [Organization](https://www.hl7.org/fhir/organization.html) |
| Zorgverlener | [Practitioner](https://www.hl7.org/fhir/practitioner.html) |
| Patient | [Patient](https://www.hl7.org/fhir/patient.html) |
| Voedingsadvies | [NutritionOrder](https://www.hl7.org/fhir/nutritionorder.html) |
| DurgsGebruik | [Observation](https://www.hl7.org/fhir/observation.html) |
| AlcoholGebruik | [Observation](https://www.hl7.org/fhir/observation.html) |
| TabakGebruik | [Observation](https://www.hl7.org/fhir/observation.html) |
| OverdrachtVerrichting | [Procedure](https://www.hl7.org/fhir/procedure.html) |
| OverdrachtTekstUitleg | [DiagnosticReport](https://www.hl7.org/fhir/diagnosticreport.html) |
| OverdrachtLaboritoriumUitslag | [Observation](https://www.hl7.org/fhir/observation.html) |
| MedicatieGebruik | [MedicationDispense](https://www.hl7.org/fhir/medicationdispense.html) |
| Lichaamslengte | [Observation](https://www.hl7.org/fhir/observation.html) |
| Lichaamsgewicht | [Observation](https://www.hl7.org/fhir/observation.html) |
| Ademhaling | [Observation](https://www.hl7.org/fhir/observation.html) |
| Pijnscore | [Observation](https://www.hl7.org/fhir/observation.html) |
| Bloeddruk | [Observation](https://www.hl7.org/fhir/observation.html) |
| Polsfrequentie | [Observation](https://www.hl7.org/fhir/observation.html) |