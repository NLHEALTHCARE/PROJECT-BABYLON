-- Script hoort bij Zorginformatiebouwsteen Alert. (https://zibs.nl/wiki/Alert(NL))
-- De FHIR resource Flag is hier deels voor gebruikt. (https://www.hl7.org/fhir/flag.html#resource)

select
        lg. iflg_id                     as "identifier"         -- AlertIdentifier. (FHIR - identifier)
        , lg.iflg_status                as "status"             -- Status van de Alert. (FHIR - status)
        , null                          as "period"             -- Tijd/Periode dat de Alert actief was. (FHIR - period)
        , ct.ifct_naam                  as "patient"            -- Patient om wie het Alert gaat.
        , lg.iflg_omschrijving          as "conditie"           -- Reden van het Alert.
        , 'https://zibs.nl/wiki/Alert(NL)#AlertNaamCodelijst'                  as "alert_naam"         -- zib's Alert definieert AlertNaamCodes: https://zibs.nl/wiki/Alert(NL)#AlertNaamCodelijst
        , 'https://zibs.nl/wiki/Alert(NL)#AlertTypeCodelijst'                  as "alert_type"         -- zib's Alert definieert AlertTypeCodes: https://zibs.nl/wiki/Alert(NL)#AlertTypeCodelijst
        
from mtdx.v_intf_logistiek lg
join mtdx.v_intf_contact ct on lg.iflg_pat_id = ct.ifct_id