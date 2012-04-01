Etantdonné /^Que mon navigateur est lancé$/ do
end
 
Quand /^Je saisi l'addresse "([^"]*)"$/ do |arg1|
    startmeasure
    @browser.goto(arg1)
end
 
Etantdonné /^Que je suis sur la page d'accueil du site "([^"]*)"$/ do |arg1|
    # j'y suis donc je n'ai rien a faire
end
 
Quand /^Je clique sur le lien "([^"]*)"$/ do |arg1|
    @browser.link(:text => arg1).click
end

Quand /^Je clique sur le lien dont l'identifiant est "([^"]*)"$/ do |arg1|
    @browser.a(:id=>arg1).click
end
 
Quand /^Je saisi "([^"]*)" dans le champ "([^"]*)"$/ do |arg1, arg2|
    @browser.text_field(:name => arg2).set(arg1)
end
 
Quand /^Je clique sur le bouton "([^"]*)"$/ do |arg1|
    startmeasure
    @browser.button(:value => arg1).click
end
 
Alors /^Je devrais voir "([^"]*)"$/ do |arg1|
    endmeasure
    @browser.text.include?(arg1).should == true
end

Etantdonné /^Que je suis authentifié sur le service cacoo$/ do
  # contexte déjà vérifié donc pas d'action en dehors de la mesure
  startmeasure
end
 
Alors /^Je devrais voir la fenêtre inspecteur$/ do
  # assertion qui sera vérifiée via sikuli au travers de xmlrpc
  @Xmlrpc_client.call("check_inspecteur").to_s.should == "0"
  endmeasure
end

Etantdonné /^Que je suis sur le nouveau schéma$/ do
  # contexte déjà vérifié
  startmeasure
end

Quand /^je clique sur le bouton fermer$/ do
  @Xmlrpc_client.call("close_schema").to_s.should == "0"
end

Alors /^je ne devrais plus voir la fenêtre schéma$/ do
  @Xmlrpc_client.call("check_schema_closed").to_s.should == "0"
  endmeasure
end

