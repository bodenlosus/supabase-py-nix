{ lib, buildPythonPackage, supabase_functions, pythonOlder, setuptools }:  # Add the original package as an argument

buildPythonPackage rec {
  pname = "supafunc-alias";
  version = "0.9.0";
  src = ./.;  # You don't need a separate source; the alias package only provides a module
  format = "pyproject";

  disabled = pythonOlder "3.9";

  nativeBuildInputs = [
    setuptools
  ];

  # Dependencies: include the original package
  propagatedBuildInputs = [ supabase_functions ];

  pythonImportsCheck = [ "supafunc" ];

  meta = with lib; {
    description = "Alias package for Supabase Functions";
    homepage = "https://github.com/supabase/functions-py";
    license = licenses.mit;
    maintainers = with maintainers; [ ris ];
  };
}
