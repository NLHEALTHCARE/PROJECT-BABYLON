select
   ifct_bsn                                     as "identifier"                 -- PatientIdentificatienummer
   , null                                       as "active"                     -- Is patientenrecord in gebruik
   , null                                       as "name_use"                   -- zib's Patient definieert Naamgebruikcodes https://zibs.nl/wiki/Patient(NL)#NaamgebruikCodelijst
   , null                                       as "name_text"                  -- Roepnaam
   , ifct_achternaam                            as "name_familiy"               -- Geslachtsnaam_Achternaam
   , ifct_voornaam                              as "name_given"                 -- Voornaam
   , null                                       as "telecom_system"             -- zib's Patient definieert NummerSoortCodes: https://zibs.nl/wiki/Patient(NL)#NummerSoortCodelijst
   , null                                       as "telecom_value"              -- zib's Patient definieert een Telefoonnummer.
   , ifct_geslacht                              as "gender"                     -- Geslacht
   , v_intf_contact.ifct_geboortedtm            as "birthdate"                  -- Geboortedatum
   , v_intf_contact.ifct_vervaldtm              as "deceased"                   -- OverlijdingsIndicator
   , v_intf_contact.ifct_straat_b               as "address_text"               -- AdresGegevens_straat
   , v_intf_contact.ifct_huisnr_b               as "address_text"               -- AdresGegevens_huisnummer
   , null                                       as "address_line"               -- zib's Patient definieert bij AdresGegevens een Huisnummerletter.
   , v_intf_contact.ifct_gebouw_b               as "address_line"               -- zib's Patient definieert bij AdresGegevens een Huisnummertoevoeging.
   , null                                       as "address_line"               -- zib's Patient definieert AanduidingBijNummerCodes: https://zibs.nl/wiki/Patient(NL)#AanduidingBijNummerCodelijst
   , v_intf_contact.ifct_postcode_b             as "address_postalCode"         -- AdresGegevens_postcode
   , v_intf_contact.ifct_plaats_b               as "adress_city"                -- AdresGegevens_woonplaats
   , null                                       as "address"                    -- zib's Patient definieert bij AdresGegevens een Gemeente.
   , v_intf_contact.ifct_lnd_omschrijving_b     as "address_country"            -- zib's Patient definieert bij AdresGegevens twee verschillende LandCodes: https://zibs.nl/wiki/Patient(NL)#LandGBACodelijst
   , null                                       as "address_line"               -- zib's Patient definieert bij AdresGegevens AdditioneleInformatie.
   , v_intf_contact.ifct_is_meerling            as "multiple_birth"             -- MeerlingIndicator.
   , v_intf_contact.ifct_voorletters_partner    as "contact_name_prefix"        -- VoorvoegselsPartner.
   , v_intf_contact.ifct_achternaam_partner     as "contact_name_family"        -- AchternaamPartner.
   , null                                       as "contact_"                   -- PartnerPatient_Identificatienummer.
   , v_intf_contact.ifct_geslacht_partner       as "contact_gender"             -- PartnerGeslacht.
   , null                                       as "contact_"                   -- zib's definieert bij Patient_Partner MeerlingIndicator, FHIR niet en staat ook niet in database.
   , null                                       as "contact_period"             -- zib's definieert bij Patient_Partner Overlijdindicator, staat niet in databse.
from mtdx.v_intf_contact 
where ifct_soort = 9                                                            -- Dit zijn patienten