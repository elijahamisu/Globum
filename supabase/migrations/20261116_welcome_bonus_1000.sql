alter table public.platform_settings alter column welcome_bonus_amount set default 1000;
update public.platform_settings set welcome_bonus_amount = 1000;
