-- Rebrand: TOP -> Globum.
alter table public.platform_settings alter column app_name set default 'Globum';
update public.platform_settings set app_name = 'Globum' where app_name is null or app_name = 'TOP';
