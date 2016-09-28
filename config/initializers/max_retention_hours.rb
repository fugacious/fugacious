hours = Rails.application.secrets.max_retention_hours.to_i || 720

raise 'Rails.application.secrets.max_retention_hours' \
' exceeds 720 hours (30 days)' if hours > 720
