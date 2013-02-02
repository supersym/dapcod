var Plugin, Σ;

Σ = require('backbone-relational');

Plugin = Σ.RelationalModel.extend({
  relations: [
    {
      type: 'HasMany',
      key: 'dependencies',
      relatedModel: 'NodePackage',
      reverseRelation: {
        key: 'plugin'
      }
    }
  ]
});

console.log(PluginModel);
