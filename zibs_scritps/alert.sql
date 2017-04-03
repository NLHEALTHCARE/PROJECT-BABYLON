-- Script hoort bij Zorginformatiebouwsteen Alert.

select
        iflg_id                 as "identifier"         -- AlertIdentifier. (FHIR)
        , iflg_status           as "status"             -- Status van de Alert. (FHIR)
        , null                  as "period"             -- Tijd/Periode dat de Alert actief was. (FHIR)
        , iflg_pat_id           as "patient"            -- Patient om wie het Alert gaat.
        , iflg_omschrijving     as "conditie"           -- Reden van het Alert.
        , null                  as "alert_naam"         -- zib's Alert definieert AlertNaamCodes: https://zibs.nl/wiki/Alert(NL)#AlertNaamCodelijst
        , null                  as "alert_type"         -- zib's Alert definieert AlertTypeCodes: https://zibs.nl/wiki/Alert(NL)#AlertTypeCodelijst
from mtdx.v_intf_logistiek