
(load-this-project
 `( (:ruby-executable ,*ruby-1.9-executable*)
    (:build-function project-compile-with-command)
    (:compile-command "rake")
    (:run-project-command (rspec-file ,(concat (project-base-directory) "spec/compiler_spec.rb")))
    (:ruby-args (,(concat "-I" (project-base-directory) "lib")))
    ) )
