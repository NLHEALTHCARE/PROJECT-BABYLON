-- Script hoort bij de Zorginformatiebouwsteen (zib) Betaler. (https://zibs.nl/wiki/Betaler(NL))
-- De FHIR resources Claim en Coverage zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/claim.html#resource) (https://www.hl7.org/fhir/coverage.html#resource)
-- Voor bepaalde CodeLijsten wordt gerefereerd naar de zib Patient, omdat deze CodeLijsten niet in de zib Betaler zijn beschreven. (https://zibs.nl/wiki/Patient(NL))

select
        ct.ifct_bsn                             as "identifier"                         -- Identificatie van de betaler. (FHIR Claim en Coverage - identifier)
        , ct.ifct_naam                          as "naam_betaler"                       -- zib definieert naam van betalende persoon of organisatie.
        , ct.ifct_bank_relatie                  as "bank_naam"                          -- zib definieert de naam van de bank.
        , ct.ifct_bicnummer                     as "bank_code"                          -- zib definieert de code van de bank, in Europa is dit de BIC code.
        , ct.ifct_ibannummer                    as "rekeningnummer"                     -- zib definieert de rekeningnummer bij de bank van de betalende persoon.
        , ct.ifct_straat_b                      as "adres_straatnaam"                   -- AdresGegevens_straat.
        , ct.ifct_huisnr_b                      as "adres_huisnummer"                   -- AdresGegevens_huisnummer.
        , null                                  as "adres_huisnummer_letter"            -- zib definieert bij AdresGegevens een Huisnummerletter.
        , ct.ifct_gebouw_b                      as "adres_huisnummer_toevoeging"        -- zib definieert bij AdresGegevens een Huisnummertoevoeging.
        , null                                  as "adres_aanduiding_bij_nummer"        -- zib definieert AanduidingBijNummerCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.7
        , ct.ifct_postcode_b                    as "adres_postcode"                     -- AdresGegevens_postcode.
        , ct.ifct_plaats_b                      as "adres_woonplaats"                   -- AdresGegevens_woonplaats.
        , null                                  as "adres_gemeente"                     -- zib definieert bij AdresGegevens een Gemeente.
        , ct.ifct_lnd_code_b                    as "adres_land"                         -- zib definieert bij AdresGegevens twee verschillende LandCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.9
        , null                                  as "address_extra_info"                 -- zib definieert bij AdresGegevens AdditioneleInformatie.
        , br.ifbr_waarde                        as "telefoon"                           -- zib definieert een Telefoonnummer.
        , null                                  as "nummer_soort"                       -- zib definieert NummerSoortCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.3
        , null                                  as "mail_adres"                         -- zib definieert een EmailAdres.
        , null                                  as "mail_soort"                         -- zib definieert EmailSoortCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.4
        , nk.ifnw_startdatum                    as "begin_datumtijd_verzekering"        -- zib definieert de begin datum dat de dekking van de verzekering geldt.
        , nk.ifnw_einddatum                     as "eind_datumtijd_verzekering"         -- zib definieert de datum tot wanneer de dekking van verzekering geldt.
        , null                                  as "verzekerings_soort"                 -- zib Betaler definieert VerzekeringssoortCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.1.1.1
        , nk.ifnw_rel_uzovi                     as "zorgverzekeraar_id"                 -- zib definieert het unieke zorgverzekeraarsidentificatienummer (UZOVI). OID: http://decor.nictiz.nl/decor/services/RetrieveOID?id=2.16.840.1.113883.2.4.6.4&language=nl-NL
        , nk.ifnw_rel_naam                      as "naam_zorgverzekeraar"               -- zib definieert de naam van de zorgverzekeraar, wanneer UZOVI wordt opgegeven dan moet naam vermeld worden zoals het in het UZOVI-register staat.
        , nk.ifnw_polisnummer                   as "verzekerde_nummer"                  -- zib definieert de nummer van patient waarmee de persoon te herkennen is bij de zorgverzekeraar.
        , st.ifst_diag_omschrijving             as "diagnose"                           -- Reden voor behandeling. (FHIR Claim - diagnosis)
        , st.ifst_zorgproduct_omschrijving      as "behandeling"                        -- Behandeling die is ondergaan. (FHIR Claim - procedure)
        , null                                  as "tijd_in_ziekenhuis"                 -- De periode dat patient in ziekenhuis was. (FHIR Claim - hospitalization)

from mtdx.v_intf_contact ct
join mtdx.v_intf_netwerk nk on ct.ifct_id = nk.ifnw_ct_id
join mtdx.v_intf_bereikbaar br on ct.ifct_id = br.ifbr_ifct_id
join mtdx.v_intf_subtraject st on ct.ifct_id = st.ifst_pat_id

where ct.ifct_soort = 9 AND nk.ifnw_polisnummer is not null --AND (nk.ifnw_einddatum is null OR nk.ifnw_einddatum > current_date)