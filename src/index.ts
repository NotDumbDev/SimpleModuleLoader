/**
 * @fileoverview A simple module loader for RBXTS.
 * @author Emilia (NotDumbDev)
 * @license MIT
 * @copyright 2025 Emilia (NotDumbDev)
 * @note Please credit the original creator (Emilia / NotDumbDev) when redistributing or modifying the project!
 */

// types \\
interface moduleCahceType {
    name: string
    module: ModuleScript
    parent: Instance | undefined
}

// cache \\
let moduleCache: moduleCahceType[] = [];

// private functions \\

function hasInitFunc(value: unknown): value is { OnInit: () => void } {
	return typeIs((value as Record<string, unknown>)["OnInit"], "function");
}

function hasStartFunc(value: unknown): value is { OnStart: () => void } {
	return typeIs((value as Record<string, unknown>)["OnStart"], "function");
}

function InitializeModule(element: moduleCahceType) {
	let initalizeTime = os.clock();
    if (hasInitFunc(element.module)) {
		element.module.OnInit();

		let elapsedTime = os.clock() - initalizeTime;
        let formattedTime = elapsedTime > 1 ? string.format("%.3f", elapsedTime) : string.format("%.2f", elapsedTime)

		warn(`[${formattedTime}s]: Intialized '${element.name}'!`);
    }
}

function StartModule(element: moduleCahceType) {
    let startTime = os.clock();
    if (hasStartFunc(element.module)) {
		element.module.OnStart();

		let elapsedTime = os.clock() - startTime;
        let formattedTime = elapsedTime > 1 ? string.format("%.3f", elapsedTime) : string.format("%.2f", elapsedTime)

		warn(`[${formattedTime}s]: Started '${element.name}'!`);
	}
}


// public api \\

async function InitializeModules(modules: Instance[]) {
	modules.forEach((module) => {
		if (!module.IsA("ModuleScript")) {
			//warn(`Element given expected to be a ModuleScript, got ${typeOf(module)}`);
			return;
		}

		if (module.Parent?.Name.lower() === ("components")) {
			return;
		}

		if (module.Parent?.Name.lower() === ("stories")) {
			return;
		}

		let mod = require(module) as ModuleScript;
		moduleCache.push({ name: tostring(module.Name), module: mod, parent: module.Parent });
	});
}

/**
 * Starts all modules.
 * @param startModules ^^ A table of module scripts
 * @yields Waits for the modules to cache before starting.
 */
export async function StartAll(startModules: Instance[]) {
    assert(startModules, `Returned 0 module scripts!`)

    await InitializeModules(startModules)
	
    moduleCache.forEach((element) => {
        InitializeModule(element)
	});

	moduleCache.forEach((element) => {
		StartModule(element)
	});
}
