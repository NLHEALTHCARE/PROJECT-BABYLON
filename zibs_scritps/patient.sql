select
   ifct_bsn                    as "identifier"
   , null                      as "active"
   , null                      as "name_use" -- ZIBS Patient definieert Naamgebruikcodes https://zibs.nl/wiki/Patient(NL)#NaamgebruikCodelijst
   , null                      as "name_text"
   , ifct_achternaam           as "name_familiy"
   , ifct_voornaam             as "name_given"
   , ifct_geslacht             as "gender"
   , v_intf_contact.ifct_geboortedtm as "birthdate"

from mtdx.v_intf_contact 
where ifct_soort = 9            -- dit zijn patienten