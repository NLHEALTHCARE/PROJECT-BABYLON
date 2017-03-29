--De volgende vragen hebben betrekking op het aantal unieke patiënten met een DBC relevant contactmoment.
-------------------
with vraag_15 as (
--15: Hoeveel patiënten hebben de afgelopen 30 dagen zorgcontact gehad met/in uw zorginstelling ? 
        select count(distinct pat.pat_id) as aant_unieke_ptn_met_zorgcontact_30
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left outer join referentie_addendum.ref_registratie_addendum reg on reg.zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                                                                                and dag.dag_datum between reg.startdatum and reg.einddatum
        
        where dag.dag_datum >= current_date - 30
            and(
                zga.zga_dbc_zorgactiviteit_code in('190060', '190013', '190012', '190011')
                or reg.zorgactiviteit_code is not null)
        ),
-- 16: Hoeveel poliklinische patiënten (incl. SEH/EHH) hebben de afgelopen 30 dagen zorgcontact gehad met/in uw zorginstelling?
-- Draaien we om: (alle contacten - de OK's van ORT); in JCI is gesteld dat OZ en DE per definitie alleen ambulante zorg leveren
vraag_16_sub_a as (
----- alle contacten afgelopen 30 dgn
        select distinct pat.pat_id 
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left outer join referentie_addendum.ref_registratie_addendum reg on reg.zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                                                                                and dag.dag_datum between reg.startdatum and reg.einddatum
        
        where dag.dag_datum >= current_date - 30
            and(
                zga.zga_dbc_zorgactiviteit_code in('190060', '190013', '190012', '190011')
                or reg.zorgactiviteit_code is not null)
        ),

vraag_16_sub_b as (
-- alle OK's van ORT afgelopen 30 dagen
        select distinct pat.pat_id 
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left outer join referentie_addendum.ref_registratie_addendum reg on reg.zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                                                                                and dag.dag_datum between reg.startdatum and reg.einddatum
        
        where dag.dag_datum >= current_date - 30
          --  and zga.zga_dbc_zorgactiviteit_code not in('190060', '190013', '190012', '190011')
            and reg.zorgactiviteit_code is not null
            and kli.kli_platform_code = 'Bewegen'
        ),
 
vraag_16_sub as (
-- alle contacten - OK's ORT
        select a.pat_id as contact_tot
                , b.pat_id as contact_niet_poli
        from vraag_16_sub_a a
        
        left join vraag_16_sub_b b on b.pat_id = a.pat_id
        
        ),

vraag_16 as (
-- aantal unieke patienten uit (alle contacten - OK's ORT)
        select count(distinct vraag_16_sub.contact_tot) as aantal_unieke_ptn_met_poli_30
        from vraag_16_sub
        where vraag_16_sub.contact_niet_poli is null 
        ),


vraag_17 as (
--Hoeveel klinische patiënten (incl. dagopnames) zijn de afgelopen 30 dagen opgenomen geweest in uw zorginstelling?        
        select count(distinct pat.pat_id) as aant_unieke_ptn_opgenomen_30
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left join referentie.ref_dbc_zorgactiviteit zkl on zkl.ref_zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                and dag.dag_datum between zkl.ref_begin_datum and coalesce(zkl.ref_eind_datum,'9999-12-31')
        
        where dag.dag_datum >= current_date - 30
        and zkl.ref_klasse_code in ('2','3')
                
        )
        

select * 
from vraag_15
cross join vraag_16
cross join vraag_17
