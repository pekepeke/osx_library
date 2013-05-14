osx-apps Cookbook
=================
This cookbooks setups the machine.

Requirements
------------

#### platform
- `mac osx`

Usage
-----
#### osx-apps::default

Just include `osx-apps` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[osx-apps]"
  ]
}
```

<!--
Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
-->

License and Authors
-------------------
Authors: pekepeke
