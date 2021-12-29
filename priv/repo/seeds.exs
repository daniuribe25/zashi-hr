alias ZashiHR.{Repo, Models.Settings.AppSettings}

date = NaiveDateTime.local_now()
Repo.insert_all(AppSettings, [
  %{ name: "logo", value: "https://res.cloudinary.com/occupapp/image/upload/v1639926797/ZashiHR/zashilogo.png", description: "App's custom logo", inserted_at: date, updated_at: date },
  %{ name: "hide_gender", value: "false", description: "Hide gender field from users information", inserted_at: date, updated_at: date },
  %{ name: "hide_marital_status", value: "false", description: "Hide marital status field from users information", inserted_at: date, updated_at: date },
  %{ name: "hide_salary", value: "false", description: "Hide salary field from users information", inserted_at: date, updated_at: date },
  %{ name: "extra_timeoff", value: "3", description: "Extra days off a user can ask even though they don't have on their balance", inserted_at: date, updated_at: date  },
  %{ name: "user_invitation_expires_after", value: "2", description: "Time (minutes) that the user invitation is valid after being sent by the admin", inserted_at: date, updated_at: date  }
])
