kwd="$(pwd)"

cd "$kwd"/1.ApplicationInsights
./run.sh

cd "$kwd"/2.FunctionIdentities
./run.sh

cd "$kwd"/3.FunctionApp
./run.sh
