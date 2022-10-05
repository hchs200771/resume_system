# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Davis"s records
candidate_davis = Candidate.create(name: "Davis")
candidate_davis.resumes.create(
  [{ name: "A", template: "A1" }, { name: "A", template: "A2" }, { name: "B", template: "B1" }]
)
candidate_davis.work_experiences.create([{ company: "Morrison Express", years: 5 }])

# Max"s records
candidate_max = Candidate.create(name: "Max")
candidate_max.resumes.create([{ name: "C", template: "C1" }, { name: "S", template: "S1" }])
candidate_max.work_experiences.create([
  { company: "Cyberbiz", years: 1 }, { company: "Solmate", years: 1 }, { company: "Morrison Express", years: 3 }
])
