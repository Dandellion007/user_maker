json.extract! resource,
              :age,
              :name,
              :patronymic,
              :email,
              :nationality,
              :country,
              :gender,
              :surname

json.interests do
  json.array! resource.interests, partial: 'interests/interest', as: :resource
end

json.skills do
  json.array! resource.skills, partial: 'skills/skill', as: :resource
end
