/**
 * @fileoverview A simple module loader for RBXTS.
 * @author Emilia (NotDumbDev)
 * @license MIT
 * @copyright 2025 Emilia (NotDumbDev)
 * @note Please credit the original creator (Emilia / NotDumbDev) when redistributing or modifying the project!
 */
/**
 * Starts all modules.
 * @param startModules ^^ A table of module scripts
 * @yields Waits for the modules to cache before starting.
 */
export declare function StartAll(startModules: Instance[]): Promise<void>;
