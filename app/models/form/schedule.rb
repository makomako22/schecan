class Form::Schedule < Schedule
  REGISTRABLE_ATTRIBUTES = %i(
    name
    schedule_at(1i) schedule_at(2i) schedule_at(3i) schedule_at(4i) schedule_at(5i)
  )
end
