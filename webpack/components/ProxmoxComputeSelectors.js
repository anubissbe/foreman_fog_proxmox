// eslint-disable-next-line import/extensions
import selectorsCatalogue from '../../config/proxmox_selectors.json';

const toOptions = options =>
  options.map(({ value, label }) => ({ value, label }));

const {
  controllers,
  vm_operating_systems: vmOperatingSystems,
} = selectorsCatalogue;
const visibleVmOperatingSystems = vmOperatingSystems.filter(
  option => !option.hidden
);

const ProxmoxComputeSelectors = {
  proxmoxTypesMap: toOptions(selectorsCatalogue.types),
  proxmoxControllersCloudinitMap: toOptions(
    controllers.filter(({ value }) => value !== 'virtio')
  ),
  proxmoxScsiControllersMap: toOptions(selectorsCatalogue.scsi_controllers),
  proxmoxArchsMap: toOptions(selectorsCatalogue.archs),
  proxmoxOstypesMap: toOptions(selectorsCatalogue.container_operating_systems),
  proxmoxOperatingSystemsMap: toOptions(visibleVmOperatingSystems),
  proxmoxVgasMap: toOptions(selectorsCatalogue.vgas),
  proxmoxCachesMap: toOptions(selectorsCatalogue.caches),
  proxmoxCpusMap: toOptions(selectorsCatalogue.cpu_types),
  proxmoxCpuFlagsMap: toOptions(selectorsCatalogue.cpu_flags),
  proxmoxScsihwMap: toOptions(selectorsCatalogue.scsi_controllers),
  proxmoxNetworkcardsMap: toOptions(selectorsCatalogue.network_cards),
  proxmoxBiosMap: toOptions(selectorsCatalogue.bios),
};

ProxmoxComputeSelectors.proxmoxControllersHDDMap = toOptions(controllers);

export default ProxmoxComputeSelectors;
