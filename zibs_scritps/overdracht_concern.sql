-- Script hoort bij de Zorginformatiebouwsteen (zib) OverdrachtConcern. (https://zibs.nl/wiki/OverdrachtConcern(NL))
-- De FHIR resource Condition is hier deels voor gebruikt. (https://www.hl7.org/fhir/condition.html#resource)
-- De zib Overdrachtverrichting is hier deels voor gebruikt voor de codelijst van de anatomische locatie.

select
        st.ifst_pat_bsn                         as "patient_id"                 -- Om welke patient gaat het. (FHIR - performer)
        , st.ifst_ba_naam                       as "zorgverlener"               -- De zorgverlener die het probleem heeft vastgelegd. (FHIR - asserter)
        , st.ifst_omschrijving                  as "concern_label"              -- zib definieert een eventuele korte omschrijving van het concern. Met name in de eerste lijn zal dit gebruikt worden voor de episodenaam.
        , null                                  as "probleem_type"              -- zib OverdrachtConcern definieert ProbleemTypeCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.5.1.1
        , null                                  as "probleem_naam"              -- zib OverdrachtConcern definieert ProbleemNaamCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.5.1.3
        , null                                  as "probleem_begin_datum"       -- zib definieert een begin van de aandoening waarop het probleem betrekking heeft. Bij klachten waarbij het lang duurt voordat de diagnose wordt gesteld is het belangrijk hoe lang de aandoening al bestaat.
        , null                                  as "probleem_status"            -- zib OverdrachtConcern definieert ProbleemStatusCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.5.1.2
        , st.ifst_startdatum                    as "probleem_status_datum"      -- zib definieert de datum vanaf wanneer de huidige waarde van de ProbleemStatus van toepassing is.
        , st.ifst_zorgproduct_omschrijving      as "toelichting"                -- zib definieert een toelicht van de persoon die het probleem heeft vastgesteld of bijgewerkt.
        , null                                  as "locatie_lichaam"            -- De anatomische locatie van het probleem. (FHIR - bodySite) (Hiervoor definieert zib VerrichtingAnatomischeLocatieCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.14.1.1)

from mtdx.v_intf_subtraject st
join mtdx.v_intf_contact ct on st.ifst_pat_id = ct.ifct_id
join mtdx.v_intf_medewerker mw on st.ifst_ba_id = mw.ifmw_id