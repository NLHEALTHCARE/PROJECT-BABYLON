-- Script hoort bij de Zorginformatiebouwsteen (zib) Patient. (https://zibs.nl/wiki/Patient(NL))
-- De FHIR resource Patient is hier deels voor gebruikt. (https://www.hl7.org/fhir/patient.html#resource)

with patient_mail_adres as
     (
        -- Uit de tabel v_intf_bereikbaar alleen de mailadressen selecteren.
        select
                distinct ifbr_waarde
                , ifbr_ifct_id
                , case
                        -- Wanneer "ifbr_ifbs_code" 201 is, dan de omschrijving van e-mailadres volgens de zib "Patient".
                        when ifbr_ifbs_code = 201
                        then 'Privé e-mailadres'
                        
                        -- Wanneer "ifbr_ifbs_code" 203 is, dan de omschrijving van directe e-mailadres volgens de zib "Patient".
                        when ifbr_ifbs_code = 203
                        then 'Zakelijk e-mailadres'
                   end as omschrijving
        
        from mtdx.v_intf_bereikbaar
        where regexp_like(ifbr_waarde, '^([0-9]*[a-z]*\.?\_?\-?[0-9]?[a-z]*\.?\-?\_?[0-9]?[a-z]*\.?[a-z]*[0-9]*)@([a-z]+\-?[a-z]*)\.([a-z]{2,3})$') AND (ifbr_ifbs_code = 201 OR ifbr_ifbs_code = 203)
     )
     , patient_telefoon as
       (
          -- Uit de tabel v_intf_bereikbaar alle telefoonnummers selecteren.
          select
                 regexp_replace(regexp_replace(lower(ifbr_waarde),'[^0-9]+',''),'[^0-9]+','') as "waarde"
                 , ifbr_ifct_id
                 , case
                        -- Wanneer "ifbr_ifbs_code" ... is, dan de omschrijving van mobiele nummer volgens de zib "Patient".
                        when ifbr_ifbs_code = 151
                        then 'Mobiel telefoonnummer'
                        
                        -- Wanneer "ifbr_ifbs_code" 153 is, dan de omschrijving van ... volgens de zib "Patient".
                        when ifbr_ifbs_code = 153
                        then 'Zakelijk telefoonnummer'
                        
                        -- Wanneer "ifbr_ifbs_code" 160 is, dan de omschrijving van telefoonnummer volgens de zib "Patient".
                        when ifbr_ifbs_code = 160
                        then 'Telefoonnummer thuis'
                        
                        -- Wanneer "ifbr_ifbs_code" 150 is, dan de omschrijving van mobiele nummer volgens de zib "Patient".
                        when ifbr_ifbs_code = 150
                        then 'Mobiel telefoonnummer'
                        
                        -- Wanneer "ifbr_ifbs_code" 110 is, dan de omschrijving van privé nummer volgens de zib "Patient".
                        when ifbr_ifbs_code = 110
                        then 'Telefoonnummer thuis'
                   end as omschrijving
        
          from mtdx.v_intf_bereikbaar
          where ifbr_ifbs_code = 151 OR ifbr_ifbs_code = 153 OR ifbr_ifbs_code = 160 OR ifbr_ifbs_code = 150 OR ifbr_ifbs_code = 110
        )
     , overleden as
        (
           -- Uit de tabel v_intf_knemerk de overlijdingsindicator halen.
           select
                   ifck_ct_id
                   , case
                           -- when een record de kenmerkcode "PIR_09" heeft dan een ja, anders een nee.
            
                           when ifck_km_code = 'PIR_09'
                           then 'ja'
            
                           else 'nee'
                     end as overleden
                   , ifck_km_code
           from mtdx.v_intf_kenmerk
        )

select
        distinct ct.ifct_bsn            as "identifier"                         -- PatientIdentificatienummer. (FHIR - identifier). OID: http://art-decor.org/decor/services/RetrieveOID?id=2.16.840.1.113883.2.4.6.3&language=nl-NL
        , null                          as "in_gebruik"                         -- Is patientenrecord in gebruik. (FHIR - active)
        , pt."waarde"                   as "telefoon"                           -- zib Patient definieert een Telefoonnummer.
        , pt.omschrijving               as "nummer_soort"                       -- zib Patient definieert NummerSoortCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.3
        , pma.ifbr_waarde               as "mail_adres"                         -- zib Patient definieert een EmailAdres.
        , pma.omschrijving              as "mail_soort"                         -- zib Patient definieert EmailSoortCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.4
        , ct.ifct_straat_b              as "adres_straatnaam"                   -- AdresGegevens_straat.
        , ct.ifct_huisnr_b              as "adres_huisnummer"                   -- AdresGegevens_huisnummer.
        , null                          as "adres_huisnummer_letter"            -- zib Patient definieert bij AdresGegevens een Huisnummerletter.
        , ct.ifct_gebouw_b              as "adres_huisnummer_toevoeging"        -- zib Patient definieert bij AdresGegevens een Huisnummertoevoeging.
        , null                          as "adres_aanduiding_bij_nummer"        -- zib Patient definieert AanduidingBijNummerCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.7
        , ct.ifct_postcode_b            as "adres_postcode"                     -- AdresGegevens_postcode.
        , ct.ifct_plaats_b              as "adres_woonplaats"                   -- AdresGegevens_woonplaats.
        , null                          as "adres_gemeente"                     -- zib Patient definieert bij AdresGegevens een Gemeente.
        , ct.ifct_lnd_code_b            as "adres_land"                         -- zib Patient definieert bij AdresGegevens twee verschillende LandCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.9 en http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.8
        , null                          as "address_extra_info"                 -- zib Patient definieert bij AdresGegevens AdditioneleInformatie.
        , null                          as "adres_soort"                        -- zib Patient definieert bij AdresSoort: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.2
        , null                          as "naam_gebruik"                       -- zib Patient definieert Naamgebruikcodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.6
        , null                          as "name_text"                          -- Volledige naam. (FHIR - name)
        , ct.ifct_voornaam              as "naam_voornaam"                      -- Voornaam.
        , ct.ifct_voorletters           as "naam_initialen"                     -- Initialen.
        , ct.ifct_achternaam            as "name_familiy"                       -- Geslachtsnaam_Achternaam.
        , ct.ifct_tussenvoegsels        as "name_given"                         -- Tussenvoegsels.
        , ct.ifct_roepnaam              as "naam_roepnaam"                      -- Roepnaam.
        , ct.ifct_geslacht              as "geslacht"                           -- Geslacht.
        , ct.ifct_geboortedtm           as "geboortedatum"                      -- Geboortedatum.
        , oln.overleden                 as "overlijdings_indicator"             -- OverlijdingsIndicator.
        , null                          as "datum_overlijden"                   -- DatumOverlijden.
        , ct.ifct_burgelijke_staat      as "burgelijke_staat"                   -- BurgelijkeStaat.
        , ct.ifct_is_meerling           as "multiple_birth"                     -- MeerlingIndicator.
        , st.ifst_ba_naam               as "zorgverlener"                       -- Wie is de arts van deze patient. (FHIR - generalPractitioner)
        , st.ifst_vest_naam             as "zorgaanbieder"                      -- Bij welke zorgaanbieder zit deze patient. (FHIR - managingOrganization)
        , null                          as "contact_relationship"               -- Soort Contactpersoon.
        , ct.ifct_voorletters_partner   as "contact_voorvoegsels"               -- ContactVoorvoegsels.
        , ct.ifct_achternaam_partner    as "contact_achternaam"                 -- ContactAchternaam.
        , null                          as "contact_identifier"                 -- Contact_Identificatienummer.
        , ct.ifct_geslacht_partner      as "contact_gender"                     -- PartnerGeslacht.
        , null                          as "contact_meerling"                   -- zib definieert bij Patient_Partner MeerlingIndicator.
        , null                          as "contact_periode_gebruik"            -- Periode waarin deze contact persoon wordt gebruikt. (FHIR - contact.period)
        , null                          as "contact_organisation"               -- Bij welke zorgaanbieder zit de contactpersoon. (FHIR - contact.organization)

from mtdx.v_intf_contact ct
join mtdx.v_intf_bereikbaar br on ct.ifct_id = br.ifbr_ifct_id
join mtdx.v_intf_subtraject st on ct.ifct_bsn = st.ifst_pat_bsn
join patient_mail_adres pma on ct.ifct_id = pma.ifbr_ifct_id
join patient_telefoon pt on ct.ifct_id = pt.ifbr_ifct_id
join overleden oln on ct.ifct_id = oln.ifck_ct_id

where ct.ifct_soort = 9                                                         -- Dit zijn patienten