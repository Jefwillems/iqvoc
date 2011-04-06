Factory.define :concept, :class => Iqvoc::Concept.base_class do |c|
  c.sequence(:origin) { |n| "_000000#{n}" }
  c.published_at 3.days.ago
  c.labelings { |labelings| [labelings.association(:pref_labeling)] }
  c.narrower_relations{ |narrower_relations| [narrower_relations.association(:narrower_relation)]}
end

Factory.define :stupid_broader_relation, :class => Iqvoc::Concept.broader_relation_class do |rel|
end

Factory.define :narrower_relation, :class => Iqvoc::Concept.broader_relation_class.narrower_class do |rel|
  rel.target {|target|
    target.association(:concept, :broader_relations => [], :narrower_relations => [], :labelings => [
        Factory.create(:pref_labeling, :target => Factory.create(:pref_label, :value => 'Some narrower relation'))
      ])
  }
  rel.after_create { |new_relation| Factory(:stupid_broader_relation, :owner => new_relation.target, :target => new_relation.owner) }
end

Factory.define :pref_labeling, :class => Iqvoc::Concept.pref_labeling_class do |lab|
  lab.target { |target| target.association(:pref_label) }
end

Factory.sequence(:label_number) { |n| n + 1 }

Factory.define :pref_label, :class => Iqvoc::Concept.pref_labeling_class.label_class do |l|
  l.language Iqvoc::Concept.pref_labeling_languages.first
  l.published_at 2.days.ago
  l.after_build do |lab|
    n = Factory.next :label_number
    lab.value = "Tree #{n}"
    lab.origin = "tree_#{n}"
  end
end

Factory.define :user do |u|
  u.forename 'Test'
  u.surname 'User'
  u.email 'testuser@iqvoc.local'
  u.password 'omgomgomg'
  u.password_confirmation 'omgomgomg'
  u.role 'reader'
  u.active true
end
