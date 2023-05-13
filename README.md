## README

This is sample project developed using ror focused on refactoring

Major refactorings done:

1. Refactored create controller and utilized hooks to perform common updations after creation of person record
2. Made use of enums of team instead of hard coded values
3. Made use of strong parameters to get params to create a person
4. Made use of scopes instead repeatdely checking of admin everytime through queries 
5. Moved appropriate codes to private methods
6. Moved from receipt to parent class ApplicationMailer
7. Added templates and letter opener gem to check the emails 
8. Usage of memoized methods to avoided reapeated queries
9. Usage of shorthand notations wherever possible
10. Also added specs for controllers 
