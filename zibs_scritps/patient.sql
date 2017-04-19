-- Script hoort bij de Zorginformatiebouwsteen (zib) Patient. (https://zibs.nl/wiki/Patient(NL))
-- De FHIR resource Patient is hier deels voor gebruikt. (https://www.hl7.org/fhir/patient.html#resource)

with patient_mail_adres as
     (
        -- Uit de tabel v_intf_bereikbaar alleen de mailadressen selecteren.
        select
                distinct ifbr_waarde
                , ifbr_ifct_id
                , ifbr_ifbs_omschrijving
        
        from mtdx.v_intf_bereikbaar
        where regexp_like(ifbr_waarde, '^([0-9]*[a-z]*\.?\_?\-?[0-9]?[a-z]*\.?\-?\_?[0-9]?[a-z]*\.?[a-z]*[0-9]*)@([a-z]+\-?[a-z]*)\.([a-z]{2,3})$') AND (ifbr_ifbs_code = 201 OR ifbr_ifbs_code = 203)
     )
     , patient_telefoon as
       (
          -- // Uit de tabel v_intf_bereikbaar alle telefoonnummers selecteren. Normale Regex: (\+?\d{2,4}?\-?\d{7,10}).
          select
                 distinct ifbr_waarde
                 , ifbr_ifct_id
                 , ifbr_ifbs_omschrijving
        
          from mtdx.v_intf_bereikbaar
          where regexp_like(ifbr_waarde, '^(\+?[0-9]{2,4}?\-?[0-9]{7,10})$') AND (ifbr_ifbs_code = 151 OR ifbr_ifbs_code = 153 OR ifbr_ifbs_code = 160 OR ifbr_ifbs_code = 150 OR ifbr_ifbs_code = 110)
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
        distinct ct.ifct_bsn            as "identifier"                         -- PatientIdentificatienummer. (FHIR - identifier)
        , null                          as "in_gebruik"                         -- Is patientenrecord in gebruik. (FHIR - active)
        , pt.ifbr_waarde                as "telefoon"                           -- zib Patient definieert een Telefoonnummer.
        , 'https://zibs.nl/wiki/Patient(NL)#NummerSoortCodelijst'                          as "nummer_soort"                       -- zib Patient definieert NummerSoortCodes: https://zibs.nl/wiki/Patient(NL)#NummerSoortCodelijst
        , pma.ifbr_waarde               as "mail_adres"                         -- zib Patient definieert een EmailAdres.
        , 'https://zibs.nl/wiki/Patient(NL)#EmailSoortCodelijst'                          as "mail_soort"                         -- zib Patient definieert EmailSoortCodes: https://zibs.nl/wiki/Patient(NL)#EmailSoortCodelijst.
        , ct.ifct_straat_b              as "adres_straatnaam"                   -- AdresGegevens_straat.
        , ct.ifct_huisnr_b              as "adres_huisnummer"                   -- AdresGegevens_huisnummer.
        , null                          as "adres_huisnummer_letter"            -- zib Patient definieert bij AdresGegevens een Huisnummerletter.
        , ct.ifct_gebouw_b              as "adres_huisnummer_toevoeging"        -- zib Patient definieert bij AdresGegevens een Huisnummertoevoeging.
        , null                          as "adres_aanduiding_bij_nummer"        -- zib Patient definieert AanduidingBijNummerCodes: https://zibs.nl/wiki/Patient(NL)#AanduidingBijNummerCodelijst
        , ct.ifct_postcode_b            as "adres_postcode"                     -- AdresGegevens_postcode.
        , ct.ifct_plaats_b              as "adres_woonplaats"                   -- AdresGegevens_woonplaats.
        , null                          as "adres_gemeente"                     -- zib Patient definieert bij AdresGegevens een Gemeente.
        , ct.ifct_lnd_omschrijving_b    as "adres_land"                         -- zib Patient definieert bij AdresGegevens twee verschillende LandCodes: https://zibs.nl/wiki/Patient(NL)#LandGBACodelijst
        , null                          as "address_extra_info"                 -- zib Patient definieert bij AdresGegevens AdditioneleInformatie.
        , 'https://zibs.nl/wiki/Patient(NL)#NaamgebruikCodelijst'                          as "naam_gebruik"                       -- zib Patient definieert Naamgebruikcodes https://zibs.nl/wiki/Patient(NL)#NaamgebruikCodelijst
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