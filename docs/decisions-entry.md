# Decisions

## 2026-10-06 — Refactored networking into a module

Moved the hub-and-spoke networking resources out of `envs/dev/main.tf` and into a reusable module at `modules/networking/`. Nothing about the deployed infrastructure changed: same 13 resources, same names, same address spaces. Only the structure changed.

**Why.** A flat `main.tf` works fine for one environment, but it does not compose. The firewall module I build next needs the hub resource group name and the firewall subnet ID, and there is no clean way to hand those over from a flat config. Modules also mean a future `envs/prod` is a 20-line module call with different numbers instead of a second copy of every resource block that then has to be kept in sync.

**Structure.** A module is a directory with three files, and I will follow the same pattern for the firewall, bastion, compute, Key Vault, and governance modules:

- `variables.tf` — the inputs the module requires: location, naming suffix, tags, the hub and spoke address spaces, and the subnet prefixes. None of these have defaults, which makes them required. The module should not decide what region or address space the caller wants, and a default address space would let two environments silently collide on the same range.
- `main.tf` — the resources the module builds: two resource groups, three VNets, four subnets, and four VNet peering resources.
- `outputs.tf` — the values the module exposes back to whoever called it.

**Variable scoping.** `var.x` always refers to a variable declared in the same directory. Inside the module, `var.suffix` is the module's own variable; inside `envs/dev`, `var.location` is that environment's. They never see each other directly. The `module` block in `envs/dev/main.tf` is the only bridge, and in it the left side of each line is the module's variable name while the right side is the value being passed in.

**Outputs.** Everything inside a module is sealed off by default. `envs/dev` cannot reference `module.networking.azurerm_subnet.firewall.id` even though that resource clearly exists. An `output` block is how a value is deliberately exposed, one at a time. So outputs are not a result or a render of what was built; they are the module's public API, chosen based on what other modules will actually need. The output's name is what callers type, and its `value` is the resource attribute it reads from. The two names are independent, and Terraform infers no relationship between them.

**Two things I had wrong at first.** The networking module creates the `AzureBastionSubnet` and `AzureFirewallSubnet` address ranges, not the Bastion host or the firewall service. Those are separate resources that belong in their own modules later, which is the cleaner split: networking owns the address space, service modules own the services. Also, peering connects VNets, not subnets. Subnets inside the same VNet already reach each other with no peering involved.

**Refactoring with live infrastructure.** Moving a resource into a module changes its Terraform address from `azurerm_subnet.firewall` to `module.networking.azurerm_subnet.firewall`. Terraform reads a new address as a new resource, so a plan against deployed infrastructure would have shown 13 destroys and 13 creates. Nothing was deployed when I did this, so it did not matter. With real infrastructure the fix is `terraform state mv` or a `moved` block, which tell Terraform the address changed without touching the cloud.
