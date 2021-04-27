PROJECT=xx.xcodeproj
SCHEME=xx
xcodebuild -project $PROJECT -scheme $SCHEME clean&&
xcodebuild -project $PROJECT -scheme $SCHEME \
-configuration Debug \
COMPILER_INDEX_STORE_ENABLE=NO \
| xcpretty -r json-compilation-database -o compile_commands.json&&
oclint-json-compilation-database -e Pods -e Vender -- \
-report-type html >> oclint_result.html \
-disable-rule ProblematicBaseClassDestructor \
-disable-rule DestructorOfVirtualClass \
-disable-rule AssignIvarOutsideAccessors \
-disable-rule ParameterReassignment \
-disable-rule ShortVariableName \
-disable-rule RedundantLocalVariable \
-disable-rule TooManyFields \
-disable-rule TooManyMethods \
-disable-rule UnusedLocalVariable \
-disable-rule UnusedMethodParameter \
-disable-rule HighCyclomaticComplexity \
-disable-rule HighNcssMethod \
-rc LongClass=1000 \
-rc LONG_LINE=200 \
-rc LongMethod=100 \
-rc TooManyParameters=8 \
-rc DeepNestedBlock=5 \
-max-priority-1=100000 \
-max-priority-2=100000 \
-max-priority-3=100000 \
rm compile_commands.json
open oclint_result.html