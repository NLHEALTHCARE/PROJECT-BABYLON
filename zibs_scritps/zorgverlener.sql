-- Script hoort bij de Zorginformatiebouwsteen (zib) Zorgverlener . (https://zibs.nl/wiki/Zorgverlener(NL))
-- De FHIR resource Practitioner is hier deels voor gebruikt. (https://www.hl7.org/fhir/practitioner.html#resource)
-- Voor bepaalde CodeLijsten wordt gerefereerd naar de zib Patient, omdat deze CodeLijsten niet in de zib Zorgverlener zijn beschreven. (https://zibs.nl/wiki/Patient(NL))

with medewerker_mail_adres as
     (
        -- Uit de tabel v_intf_bereikbaar_mdw alleen de mailadressen selecteren.
        select
                distinct ifmb_ifmw_id 
                , ifmb_waarde
        from mtdx.v_intf_bereikbaar_mdw
        where ifmb_ifbs_omschrijving LIKE '%Mail%'
     )
     , medewerker_telefoon as
       (
          -- // Uit de tabel v_intf_bereikbaar_mdw alle telefoonnummers selecteren.
          select
                  ifmb_ifmw_id
                  , ifmb_waarde
                  , ifmb_ifbs_omschrijving
          from mtdx.v_intf_bereikbaar_mdw
          where ifmb_ifbs_omschrijving = 'Telefoon' OR ifmb_ifbs_omschrijving = 'Tel. privé' OR ifmb_ifbs_omschrijving LIKE 'Mobiel privé'
        )

select
      mw.ifmw_agb                       as "zorgerverlener_identificatienr"             -- zib definieert een Zorgindentificatienummer kan via AGB of UZI.
      , null                            as "in_gebruik"                                 -- Is de zorgverlener van dit dossier nog actief. (FHIR - active)
      , null                            as "naam_gebruik"                               -- zib Patient definieert Naamgebruikcodes https://zibs.nl/wiki/Patient(NL)#NaamgebruikCodelijst
      , null                            as "name_text"                                  -- Volledige naam. (FHIR - name)
      , mw.ifmw_voornaam                as "naam_voornaam"                              -- Voornaam.
      , mw.ifmw_voorletters             as "naam_initialen"                             -- Initialen.
      , mw.ifmw_achternaam              as "name_familiy"                               -- Geslachtsnaam_Achternaam.
      , mw.ifmw_tussenvoegsels          as "name_given"                                 -- Tussenvoegsels.
      , null                            as "naam_roepnaam"                              -- Roepnaam.
      , mw.ifmw_rollen                  as "specialisme"                                -- zib Zorgverlener definieert SpecialismeCodes volgens AGB of UZI: https://zibs.nl/wiki/Zorgverlener(NL)#SpecialismeAGBCodelijst en https://zibs.nl/wiki/Zorgverlener(NL)#SpecialismeUZICodelijst
      , mw.ifmw_straat_pr               as "adres_straatnaam"                           -- AdresGegevens_straat.
      , mw.ifmw_huisnr_pr               as "adres_huisnummer"                           -- AdresGegevens_huisnummer.
      , null                            as "adres_huisnummer_letter"                    -- zib definieert bij AdresGegevens een Huisnummerletter.
      , mw.ifmw_gebouw_pr               as "adres_huisnummer_toevoeging"                -- zib definieert bij AdresGegevens een Huisnummertoevoeging.
      , null                            as "adres_aanduiding_bij_nummer"                -- zib definieert AanduidingBijNummerCodes: https://zibs.nl/wiki/Patient(NL)#AanduidingBijNummerCodelijst
      , mw.ifmw_postcode_pr             as "adres_postcode"                             -- AdresGegevens_postcode.
      , mw.ifmw_plaats_pr               as "adres_woonplaats"                           -- AdresGegevens_woonplaats.
      , null                            as "adres_gemeente"                             -- zib definieert bij AdresGegevens een Gemeente.
      , mw.ifmw_lnd_omschrijving_pr     as "adres_land"                                 -- zib definieert bij AdresGegevens twee verschillende LandCodes: https://zibs.nl/wiki/Patient(NL)#LandGBACodelijst
      , null                            as "address_extra_info"                         -- zib definieert bij AdresGegevens AdditioneleInformatie.
      , mwt.ifmb_waarde                 as "telefoon"                                   -- zib definieert een Telefoonnummer.
      , null                            as "nummer_soort"                               -- zib definieert NummerSoortCodes: https://zibs.nl/wiki/Patient(NL)#NummerSoortCodelijst
      , mwma.ifmb_waarde                as "mail_adres"                                 -- zib definieert een EmailAdres.
      , null                            as "mail_soort"                                 -- zib definieert EmailSoortCodes: https://zibs.nl/wiki/Patient(NL)#EmailSoortCodelijst
      , mw.ifmw_vst_naam                as "zorgaanbieder"                              -- zib definieert de organisatie waar de zorgverlener werkzaam is.
      , null                            as "zorgverlener_rol"                           -- zib Zorgverlener definieert ZorgverlenerRolCodes: https://zibs.nl/wiki/Zorgverlener(NL)#ZorgverlenerRolCodelijst
      , mw.ifmw_geslacht                as "geslacht"                                   -- Het geslacht van de zorgverlener. (FHIR - gender)
  
from mtdx.v_intf_medewerker mw
join medewerker_mail_adres mwma on mw.ifmw_id = mwma.ifmb_ifmw_id
join medewerker_telefoon mwt on mw.ifmw_id = mwt.ifmb_ifmw_id
join mtdx.v_intf_vestiging vs on mw.ifmw_vst_code = vs.ifvs_code