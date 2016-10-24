@echo off

echo Cleaning directory...

if exist Debug (
   echo Removing Debug directory
   rd Debug /s /q
) else (
   echo Debug directory does not exist
)

if exist cs308_program2\Debug (
   echo Removing cs308_program2\Debug directory
   rd cs308_program2\Debug /s /q
)

if exist Release (
   echo Removing Release directory
   rd Release /s /q
) else (
   echo Release directory does not exist
)

for %%F in (cs308_program2\*.lst) do (
   echo Removing %%F
   del /q %%F
)

for %%F in (*.sdf) do (
   echo Removing %%F
   del /q %%F
)

if exist ipch rd ipch /s /q

timeout /t 5
