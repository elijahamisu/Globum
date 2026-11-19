-- Withdrawal charge back to 15%, editable in Admin > Settings.
alter table public.platform_settings alter column withdrawal_fee_percent set default 15;
update public.platform_settings set withdrawal_fee_percent = 15;
do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'platform_settings_withdrawal_fee_range') then
    alter table public.platform_settings add constraint platform_settings_withdrawal_fee_range check (withdrawal_fee_percent >= 0 and withdrawal_fee_percent <= 100);
  end if;
end $$;
