## CHANGES THAT NEEDS TO BE MADE FOR THE CODE DEPLOY AND CODE PIPELINE IMPLEMENTATION

1. Update LINE `4` in the `appspect.yml` from `webapp/target/webapp.war` to `target/webapp.war`

2. Update LINE `26` in the `buildspec.yml` and change the following line from `- target/*.war` to `- '**/*'`