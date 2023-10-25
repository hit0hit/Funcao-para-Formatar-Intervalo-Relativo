create or replace FUNCTION formatar_intervalo_relativo(p_timestamp1 IN TIMESTAMP, p_timestamp2 IN TIMESTAMP) RETURN VARCHAR2 IS
  l_seconds_ago NUMBER;
  l_minutes_ago NUMBER;
  l_hours_ago NUMBER;
  l_days_ago NUMBER;
  l_weeks_ago NUMBER;
  l_months_ago NUMBER;
  l_years_ago NUMBER;
  l_result VARCHAR2(100);
BEGIN
  l_seconds_ago := ROUND(EXTRACT(DAY FROM (p_timestamp1 - p_timestamp2)) * 24 * 60 * 60
                          + EXTRACT(HOUR FROM (p_timestamp1 - p_timestamp2)) * 60 * 60
                          + EXTRACT(MINUTE FROM (p_timestamp1 - p_timestamp2)) * 60
                          + EXTRACT(SECOND FROM (p_timestamp1 - p_timestamp2)));
  l_minutes_ago := FLOOR(l_seconds_ago / 60);
  l_hours_ago := FLOOR(l_seconds_ago / 3600);
  l_days_ago := FLOOR(l_seconds_ago / (3600 * 24));
  l_weeks_ago := FLOOR(l_seconds_ago / (3600 * 24 * 7));
  l_months_ago := FLOOR(l_seconds_ago / (3600 * 24 * 30));
  l_years_ago := FLOOR(l_seconds_ago / (3600 * 24 * 365));
  IF l_seconds_ago < 60 THEN
    l_result := l_seconds_ago || ' segundos';
  ELSIF l_minutes_ago < 60 THEN
    l_result := l_minutes_ago || ' minutos';
  ELSIF l_hours_ago < 24 THEN
    l_result := l_hours_ago || ' horas';
  ELSIF l_days_ago < 7 THEN
    l_result := l_days_ago || ' dias';
  ELSIF l_weeks_ago < 4 THEN
    l_result := l_weeks_ago || ' semanas';
  ELSIF l_months_ago < 12 THEN
    l_result := l_months_ago || ' meses';
  ELSE
    l_result := l_years_ago || ' anos';
  END IF;
  RETURN l_result;
END;


select formatar_intervalo_relativo(sysdate, sysdate - 1 ) from dual
