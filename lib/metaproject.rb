require 'metaproject/dsl'

MYDSL = MetaProject::DSL.new

def project name, &block
  MYDSL.project name, &block
end